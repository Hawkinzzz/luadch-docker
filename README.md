Luadch
This is a completely funcional Docker image with Luadch application.

Based on Alpine Linux, which provides a very small size.

Tested and working on Synology and QNAP, but should work on any x86_64 devices.

Sample run command:
```bash
docker run -d --name=luadch
-e PGID=0 -e PUID=0 -e TZ=Europe/Stockholm
-p 5000:5000
-p 5001:5001
-v "/share/Container/luadch:/config"
docker pull hawkinzzz/luadch
```