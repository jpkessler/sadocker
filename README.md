# sadocker
Yet Another Spamassassin Docker

### USAGE


docker build -f Dockerfile -t ruvspamassassin:mybuild .
docker run -p 127.0.0.1:786:783 -it ruvspamassassin:mybuild

docker exec 13f6a16fd1d4 /init.sh

cat HAM.txt | spamc -d 127.0.0.1 -l -p 786 -s 4096000 --retry-sleep 30 -c
cat HAM.txt | spamc -d 127.0.0.1 -l -p 786 -s 4096000 --retry-sleep 30 -R

