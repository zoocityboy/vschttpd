# VSCHTTPD

Dart server for hosting your local flutter web apps inside the VS Code extension webview iframe


## Instalation

```bash
pub global activate vschttpd
```

## Run 

inside a flutter app run 

```bash
vschttpd --port YOURPORT --path build/web --address localhost
```

## Configure

```bash
vschttpd --help
FormatException: Could not find an option named "help".
-p, --port       Port to listen on.
                 (defaults to "9001")
-r, --path       Path to serve.
                 (defaults to "C:\Users\zooci\Develop\hci\self-care-mobile\dynamic_forms_playground")
-a, --address    Address to listen on.
                 [localhost, 127.0.0.1 (default), ::1]
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