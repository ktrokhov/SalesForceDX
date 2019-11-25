1. http://packagebuilder.herokuapp.com/ c помощью этой штуки сделал package.xml
2. sfdx force:auth:web:login -d -a DevHub // зайти из консоли в Dev среду
3. sfdx force:org:list //инфомация в каких аккаунтах сидим (вошли)
4. sfdx force:mdapi:retrieve -r (Каталог где лежит packgame.xml) -u (username in SF) -k package.xml
5. unzip -o <path/unpackaged.zip> -d (current location)
6. sfdx force:mdapi:deploy -c (deploy only validate targets) -d (folder location) -u (username) -w (wait time in min)




 Что-то много всех данных падает, не могу понять причину, попробовал на двух файлах- работает(описал xml для двух lightning components) и сделал все по алгоритму 

