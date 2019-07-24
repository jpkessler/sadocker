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
  -5.1/5.0

# test full report
cat samples/SPAM.txt | spamc -R -d 127.0.0.1 -l -p 786 -s 4096000 --retry-sleep 30
  995.2/5.0
  Spam detection software, has identified this incoming email
  as possible spam.  The original message has been attached to this
  so you can view it or label
  similar future email.  If you have any questions, see
  the administrator of that system for details.

  Content analysis details:   (995.2 points, 5.0 required)

   pts rule name              description
  ---- ---------------------- --------------------------------------------------
  -5.0 RCVD_IN_DNSWL_HI       RBL: Sender listed at https://www.dnswl.org/,
                              high trust
                              [81.169.142.168 listed in list.dnswl.org]
  1000 GTUBE                  BODY: Generic Test for Unsolicited Bulk Email
   0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily
                              valid
   0.1 DKIM_INVALID           DKIM or DK signature exists, but is not valid
```

