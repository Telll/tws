function LongPolling(method, url, delimiter, headers) {
	this.method     = method;
	this.url        = url;
	this.delimiter  = delimiter || "\n//----------//";
	this.headers    = headers;
	this.xhr        = this._createXHR();
}

LongPolling.prototype = {
	_createXHR:     function() {
		var xhr = new XMLHttpRequest();
		xhr.open(this.method, this.url, true);
		for(var key in this.headers) {
			xhr.setRequestHeader(key, this.headers[key]);
		}
		return xhr;
	},

	connect:        function() {
		var index = 0;

		this.xhr.onreadystatechange = function() {
			if(this.xhr.readyState == 3) {
				var i = this.xhr.responseText.lastIndexOf(this.delimiter);
				if (i > index) {
					var newChunk = this.xhr.responseText.substr(index, (i - index));
					index = i + this.delimiter.length;
					if(newChunk != "alive?" && this.onData)
						setTimeout(this.onData.bind(this, newChunk), 0);

				}
			}
		}.bind(this);
		this.xhr.onabort = this.xhr.onerror = function() {
			this.xhr = this._createXHR();
			try {
				this.connect();
			} catch(err) {
				setTimeout(this.connect.bind(this), 100);
			}
		}.bind(this);
		this.xhr.send(null);
	}
};

var lp = new LongPolling("GET", "http://52.3.72.192:3000/app/photolink/lp", "\n//----------//", {"X-Api-Key": 123, "X-Auth-Key": "4574eb62ff5337ce17f3d657f3b74cbcf3f9cc42"});
lp.onData = function(data) {alert(data)};
lp.connect();
