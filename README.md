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
