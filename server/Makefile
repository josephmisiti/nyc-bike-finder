build:
	go build -o bin/server server.go db_writer.go
	
clean:
	rm server
	
cron:
	bin/server -runCron

help:
	bin/server -h
	
test:
	go test