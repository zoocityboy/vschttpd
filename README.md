![VSCHTTPD](https://raw.githubusercontent.com/zoocityboy/vschttpd/main/media/artboard.png?token=ATOW7I4NWM5UANKPMOSPHD3BREQAS)

# VSCHTTPD

Dart server for hosting your local flutter web apps inside the VS Code extension webview iframe


## Instalation

```bash
pub global activate vschttpd
```

## Run 

inside a flutter app run 

```bash
vschttpd -p YOURPORT -r build/web
```

## Configure

```bash
vschttpd --help
-p, --port                Port to listen on.
                          (defaults to "9001")
-r, --root (mandatory)    The path to serve. If not set, the current directory is used.
-a, --address             Address to listen on.
                          (defaults to "localhost")
```


## VS Code Extensions

Inside your extensions web panel use this snippet for bypass cors

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Security-Policy" content="default-src 'none'; frame-src ${uri} ${cspSource} http: https:; img-src ${cspSource}; style-src ${uri} ${cspSource}; script-src ${uri} 'nonce-${nonce}';">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="${stylesResetUri}" rel="stylesheet">
        <link href="${stylesMainUri}" rel="stylesheet"> 
    </head>
    <body>
        <iframe id="iframe-content" src="${uri}" frameborder="0" scroll="no"/>
        <script type="text/javascript" nonce="${nonce}" src="${scriptUri}"></script>  
    </body>
</html>
```
where uri should be

```bash
http://YOURADDRESS:PORT
```