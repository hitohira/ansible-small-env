// exec command: node index.js <port>

let _port_val = 8080;
if(process.argv.length > 2){
	const argv2 = process.argv[2];
	if(!isNaN(argv2)){
 		_port_val = argv2;
	}
}

const port = _port_val;

const express = require('express');
const app = express();
const http = require('http');

app.get("/",(req,res,next) => {
	if(req.query.data === undefined){
		res.status(200).send(`[port=${port}] access with data parameter!`);
	}
	else{
		const data = req.query.data;
		res.status(200).send(`[port=${port}] passed data is ${data}.`);
	}
});

app.use((req,res,next) => {
	res.status(404).send("URL not found");
});

app.listen(port, () => {
	console.log('app listening on port '+port);
});

