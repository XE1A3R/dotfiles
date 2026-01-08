# Dotfiles

## Описание

Этот репозиторий содержит мои персональные конфигурационные файлы (dotfiles) для различных программ и инструментов, используемых в моем окружении Linux. Dotfiles - это скрытые файлы конфигурации, которые находятся в домашней директории пользователя и определяют настройки различных приложений и системных утилит.

## Установка

Для установки dotfiles используйте алиас `dotfiles`, который настроен на специальный git-репозиторий:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Для клонирования репозитория выполните следующие команды:

```bash
git clone --bare <URL_репозитория> $HOME/.dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

После этого вы можете использовать команду `dotfiles` для управления изменениями в конфигурационных файлах.

## Использование

После установки вы можете использовать стандартные команды git для управления dotfiles:

- `dotfiles status` - проверка статуса изменений
- `dotfiles add <файл>` - добавление файла к отслеживанию
- `dotfiles commit -m "сообщение"` - создание коммита
- `dotfiles push` - отправка изменений в удаленный репозиторий
- `dotfiles pull` - получение изменений из удаленного репозитория

## Внесение изменений

При изменении конфигурационных файлов в домашней директории, вы можете добавить их к отслеживанию с помощью команды `dotfiles add`, затем создать коммит с описанием изменений и отправить их в удаленный репозиторий.

<div align="center">
  <a href="https://github.com/XE1A3R" alt="https://github.com/XE1A3R"><img src="https://img.shields.io/static/v1?style=for-the-badge&label=CREATED%20BY&message=XE1A3R&color=000000"></a>
  <a href="https://github.com/XE1A3R/dotfiles/blob/master/LICENSE" alt="https://github.com/XE1A3R/dotfiles/blob/master/LICENSE"><img src="https://img.shields.io/static/v1?style=for-the-badge&label=LICENSE&message=MIT&color=000000"></a>
</div>
