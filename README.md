# sadocker

Yet Another Spamassassin Docker

### USAGE


```bash
# build image
docker build -f Dockerfile -t ruvspamassassin:mybuild .

# run container
docker run -p 127.0.0.1:786:783 -it ruvspamassassin:mybuild
```
```bash
# update ruleset
docker exec <container-name> /init.sh
```
```bash
# test result only
cat samples/HAM.txt | spamc -c -d 127.0.0.1 -l -p 786 -s 4096000 --retry-sleep 30

# test full report
cat samples/HAM.txt | spamc -R -d 127.0.0.1 -l -p 786 -s 4096000 --retry-sleep 30
```

