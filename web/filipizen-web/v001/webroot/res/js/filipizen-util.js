var FilipizenUtil = new function() {
	var self = this;
	this.files = {};

	this.randomString = function( length ) {
		var mask = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_+-'
		var result = '';
		for (var i=0; i<length; i++) {
			result += mask[Math.floor(Math.random() * mask.length)];
		}
		return result;
	}

	this.findItem = function( list, jsondata, key ) {
		var val = jsondata[key];
		return list.find(function( o ) {
				return (val == o[key]);
			});
	}

	this.removeItem = function( list, jsondata, key ) {
		var val = jsondata[key];
		var idx = list.findIndex(function( o ) {
			return (val == o[key]);
		});
		if (idx > -1) list.splice(idx, 1);
	}

	this.sortByKey = function( src, key ) {
		if (src) {
			var list = self.copyArray( src );
			list.sort(function(a, b) {
				return (a[key] < b[key] ? -1 : 0);
			});
			return list;
		}
		return src;
	}

	this.copyObject = function( src ) {
		var obj = {};
		if (src) {
			for (k in src) {
				var val = src[k];
				if (Array.isArray(val)) {
					obj[k] = self.copyArray(val);
				} else if (val instanceof Map) {
					obj[k] = self.copyMap(val);
				} else if (val instanceof Object) {
					obj[k] = self.copyObject(val);
				} else {
					obj[k] = val;
				}
			}
		}
		return obj;
	}

	this.copyMap = function( src ) {
		var map = new Map();
		if (src) {
			var itr = src.keys();
			while (true) {
				var n = itr.next();
				if (n.done) {
					break;
				}
				var k = n.value;
				var val = src.get(k);
				if (Array.isArray(val)) {
					map.set(k, self.copyArray(val));
				} else if (val instanceof Map) {
					map.set(k, self.copyMap(val));
				} else if (val instanceof Object) {
					map.set(k, self.copyObject(val));
				} else {
					map.set(k, val);
				}
			}
		}
		return map;
	}

	this.copyArray = function( src ) {
		var list = [];
		if (src) {
			for (var i=0; i<src.length; i++) {
				var x = src[i];
				if (Array.isArray(x)) {
					list.push( self.copyArray(x) );
				} else if (x instanceof Map) {
					list.push( self.copyMap(x) );
				} else if (x instanceof Object) {
					list.push( self.copyObject(x) );
				} else {
					list.push( x );
				}
			}
		}
		return list;
	}

	this.setObject = function( data, src ) {
		for (k in src) {
			var val = src[k];
			if (val instanceof Object) {
				if (!data[k]) data[k] = {};
				self.setObject(data[k], val);
			} else {
				data[k] = val;
			}
		}
	}

	this.fileUploadChangeEventListener = function( id, callback ) {
		if (!callback) {
			callback = function() {
				self.uploadFile(this);
			}
		}
		$(id).change(callback);
	}

	this.uploadFile = function(input, key) {
		if (input && input.files) {
			let f = input.files[0];
			key = f.name;
			if (!key) key = 'default';
			self.files[key] = input.files[0];
		}
	}

	this.getFiles = function() {
		console.log('get files');
		if (self.files) return self.files;
		return null;
	}

	this.getFile = function(key) {
		if (!key) key = 'default';
		if (self.files) return self.files[key];
		return null;
	}
}