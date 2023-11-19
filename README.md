Встановити Golang та налаштувати середовище розробки (Codespaces вже містить всі необхідні налаштування)
Створити новий проєкт на GitHub та налаштувати Git.

	echo "# kbot" >> README.md
	git init
	git add README.md
	git commit -m "first commit"
	git branch -M main
	git remote add origin https://github.com/cipgen/kbot.git push -u origin main

Додати залежність на бібліотеку github.com/spf13/cobra за домопогою import (практичне завдання продемонстровано в лекції 2.4)

	go install github.com/spf13/cobra-cli@latest  
	cobra-cli init  

	import (
	"github.com/spf13/cobra"
	)

Створити Telegram-бота за допомогою BotFather.
	Find BotFather -->
	/newbot
	kbot
	cipgen_bot

Отримати токен бота та зберегти його у змінну середовища TELE_TOKEN.
read -s TELE_TOKEN 

Імпортувати необхідні бібліотеки.
Встановити бібліотеку gopkg.in/telebot.v3 за допомогою go get.
	go get -u gopkg.in/telebot.v3  
	gofmt -s -w ./  
	go get  
Отримати токен бота зі змінної середовища.
	echo $TELE_TOKEN  
	export TELE_TOKEN  

Створити об'єкт бота за допомогою telebot.NewBot().
	kbot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  TeleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		}

Додати обробник повідомлень за допомогою kbot.Handle(telebot.OnText, func(m telebot.Context)
Описати функцію-обробник, яка буде відповідати на повідомлення.
	kbot.Handle(telebot.OnText, func(m telebot.Context) error {

			log.Print(m.Message().Payload, m.Text())
			payload := m.Message().Payload

			switch payload {

			case "hello":
				err = m.Send(fmt.Sprintf("Hello I'm Kbot %s !", appVersion))

			}

			return err

		})

Зібрати, запустити та перевірити бота

go build -ldflags "-X="github.com/cipgen/kbot/cmd.appVersion=v1.0.3  

Створити файл README з описом проєкту, посиланням на бота у форматі t.me/<Імʼя_бота>_bot, включаючи інструкції для встановлення та приклади використання команд.

t.me/cipgen_bot

example

/start hello - "get bot version"
/start [pwhat's your name, what is your name, name] - "get bot name"
/start [what time is it, time] - "get time UTC"


Завантажити код на GitHub.
Надіслати посилання на репозиторій як відповідь


-= Commands for me=-  

  
go version  
go mod init github.com/cipgen/kbot  
go install github.com/spf13/cobra-cli@latest  
cobra-cli init  
cobra-cli add version  
go run main.go help  
go run main.go version  
cobra-cli add kbot  
go build -ldflags "-X="github.com/cipgen/kbot/cmd.appVersion=v1.0.0  
./kbot  
./kbot version  
git add .  
git commit -m "first app kbot"  
git branch  
git remote -v  
git push  


________

go get -u gopkg.in/telebot.v3  
gofmt -s -w ./  
go get  
go build -ldflags "-X="github.com/cipgen/kbot/cmd.appVersion=v1.0.1  
./kbot  
./kbot start  
read -s TELE_TOKEN  
echo $TELE_TOKEN  
export TELE_TOKEN  
go build -ldflags "-X="github.com/cipgen/kbot/cmd.appVersion=v1.0.2  


6819611883:AAG5my3l9m8KQV1IrjBNw6etNG9VaxgBtfE