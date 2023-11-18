-= Commands =-  

  
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
go build -ldflags "-X="https://github.com/cipgen/kbot/cmd.appVersion=v1.0.1
./kbot
./kbot start
read -s TELE_TOKEN
echo $TELE_TOKEN
export TELE_TOKEN
go build -ldflags "-X="https://github.com/cipgen/kbot/cmd.appVersion=v1.0.2