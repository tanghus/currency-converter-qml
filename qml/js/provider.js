WorkerScript.onMessage = function(message) {
    var url = 'http://download.finance.yahoo.com/d/quotes.csv?s={quote}=X&f=l1&e=.csv'.replace('{quote}', message.quote);

    var xhr = new XMLHttpRequest()

    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            console.log('status', xhr.status, xhr.statusText)
            console.log('response', xhr.responseText)
            if(xhr.status === 200) {
                WorkerScript.sendMessage({quote: xhr.responseText});
            } else {
                WorkerScript.sendMessage({error: xhr.statusText, message: xhr.responseText});
            }
        }
    }

    xhr.open('GET', url, true);
    xhr.send();
}
