Настройка сервера Debian/ubuntu

1. В файл hosts  внести IP адрес сервера
2. group_vars\debian_sli указать путь к ключу ssh
3. Тест подключения 
ansible all -m ping  -i hosts

4. tasks\main
Включить-выключить нужные пункты
- debian_only
- iptables
- port_knoking

Запуск playbook
ansible-playbook  playbook.yaml  -i hosts  -vD
