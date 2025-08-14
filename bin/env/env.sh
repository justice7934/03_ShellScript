#!/bin/bash

set -e
###################################
# 1. 통신 확인
###################################
for i in 10 20 30
do
    ping -c 1 192.168.10.$i >/dev/null 2>&1 \
      && echo "[ OK ] 192.168.10.$i" \
      || echo "[ FAIL ] 192.168.10.$i"
done
###################################
# 2. multi-user.target 변경
###################################
yum -q -y install sshpass

for i in 20 30
do
  sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no 192.168.10.$i \
    'systemctl set-default multi-user.target'
  sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no 192.168.10.$i \
    'systemctl isolate multi-user.target'
done

###################################
# 3. 스크린 락(Screen Lock) 해제, 절전 모드 끄기(Power Saving OFF) 
###################################

# 빈 화면 지연 시간: 안함
gsettings set org.gnome.desktop.session idle-delay 0
# 자동 화면 잠금: 비활성화
gsettings set org.gnome.desktop.screensaver lock-enabled false
# 전원 모드 설정
# gsettings set org.gnome.settings-daemon.plugins.power power-profile 'performance'
dconf write /org/gnome/settings-daemon/plugins/power/power-profile "'performance'"

###################################
# 4. 방화벽 OFF, SELinux OFF
###################################

for i in 10 20 30
do
    sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no 192.168.10.$i \
        systemctl disable --now firewalld
    sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no 192.168.10.$i \
        "sed -i 's/SELinux=enforcing/SELinux=permissive/' /etc/selinux/config"
    sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no 192.168.10.$i \
        "setenforce 0"
done

###################################
# 5. 공개키 인증 방식 설정
###################################

# (ㄱ) 키 생성
yes | ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''

# (ㄴ) 키 배포
for i in 10 20 30
do
    sshpass -p 'soldesk1.' ssh-copy-id -o StrictHostKeyChecking=no \
        -i ~/.ssh/id_rsa.pub root@192.168.10.$i
done

# (ㄷ) 확인 및 테스트
for i in 10 20 30
do
    ssh 192.168.10.$i hostname
done

###################################
# 6. 한국어 설정 - 한글 키보드 사용
###################################

# 한국어(Hangul) 추가
gsettings set org.gnome.desktop.input-sources ["('ibus', 'hangul'), ('xkb','us')"]
gsettings get org.gnome.dsektop.input-sources

###################################
# 7. 폰트 설정, PS1 설정, /etc/hosts 설정
###################################

# (ㄱ) 선수 패키지 설치
yum -q -y install gnome-tweaks

# (ㄴ) 폰트 설정
gsettings set org.gnome.desktop.interface monospace-font-name 'MonoSpace Bold 18'

# (ㄷ) 확장(gnome Extension) 기능 ON
for item in $(gnome-extensions list)
do
    gnome-extensions enable "$item"
done

# (ㄹ) 바탕화면에 터미널 아이콘 생성
[ -d ~/바탕화면 ] && cp /usr/share/applications/org.gnome.Terminal.desktop ~/바탕화면
[ -d ~/Desktop ] && cp /usr/share/applications/org.gnome.Terminal.desktop ~/Desktop

# (ㄱ) /etc/hosts 파일 생성
cat << EOF > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.10.10 main.example.com     main
192.168.10.20 server1.example.com  server1
192.168.10.30 server2.example.com  server2

EOF

# (ㄴ) /etc/hosts 파일 다른서버(server1, server2)로 복사
scp /etc/hosts 192.168.10.20:/etc/hosts
scp /etc/hosts 192.168.10.30:/etc/hosts

###################################
# 8. 새로운 NIC 카드 장착
###################################

#!/bin/bash

START=200
END=230
NET=172.16.6
BACKUP="position.txt.bak"

cp -f position.txt "$BACKUP"
for i in $(seq $START $END)
do
    # echo "$NE.$i"
    ping -c 1 -W 0.5 $NET.$i >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $NET.$i"
        sed -i "s/$i/OOO/" position.txt
    else
        echo "[ FAIL ] $NET.$i"
        sed -i "s/$i/XXX/" position.txt
    fi
done

echo "=== 핑 테스트 완료! 자리 배치도 확인 ==="
cat position.txt

# 원본 복구
mv -f "$BACKUP" position.txt
cat position.txt
