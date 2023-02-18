require('dotenv').config();
const express = require('express');
var mysql = require('mysql');
const moment = require('moment');
const path = require('path');
const cors = require('cors');
const multer = require('multer');
const fs = require('fs');

// Image file Upload settings
var storage = multer.diskStorage({
    destination: '../Public/uploads/',
    filename: function(req, file, cb) {
        let file_name = file.originalname.replace(path.extname(file.originalname), "") + '-' + Date.now() + path.extname(file.originalname);
        cb(null, file_name);
    }
});

var upload = multer({ storage: storage });

const app = express();
const port = process.env.PORT;
const token = process.env.TOKEN;
const debug = process.env.DEBUG;
const version = process.env.VERSION;

var pool = mysql.createPool({
    connectionLimit: 10,
    host: process.env.DBHOST,
    user: process.env.DBUSER,
    password: process.env.DBPASS,
    database: process.env.DBNAME
});

app.use(cors());
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// file upload
app.post('/fileUpload', upload.single('file'), (req, res) => {
    log(req.socket.remoteAddress, `1 File uploaded to /Public/uploads (${req.file.filename}`);
    res.status(200).json(req.file);
});

// file Delete
app.delete('/fileDelete/:table/:id', tokencheck(), (req, res) => {
    let table = req.params.table;
    let id = req.params.id;
    pool.query(`SELECT filename FROM ${table} WHERE ID=${id}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            if (results[0].filename != '') {
                fs.rm('../Public/uploads/' + results[0].filename, (err) => {
                    if (err) {
                        log(req.socket.remoteAddress, err);
                        res.status(500).send(err);
                    }
                });
            }
            res.status(200).json(results[0].filename);
        }
    });
});

// GET VERSION INFO
app.get('/', (req, res) => {
    log(req.socket.remoteAddress, `Sent version information.`);
    res.status(200).send(`2/14.szft Backend MySQL API ${version}.`);
});

// LOGINCHECK
app.post('/login', tokencheck(), (req, res) => {
    var table = req.body.table;
    var email = req.body.email;
    var passwd = req.body.password;

    pool.query(`SELECT * FROM ${table}  WHERE email=? AND passwd=?`, [email, passwd], (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table (logincheck).`);
            res.status(200).send(results);
        }
    });

});

// GET ALL RECORDS
app.get('/:table', tokencheck(), (req, res) => {
    var table = req.params.table;
    pool.query(`SELECT * FROM ${table}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// GET ONE RECORD BY ID
app.get('/:table/:id', tokencheck(), (req, res) => {
    var table = req.params.table;
    var id = req.params.id;
    pool.query(`SELECT * FROM ${table} WHERE ID=${id}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} record sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// GET RECORDS BY field
app.get('/:table/:field/:value', tokencheck(), (req, res) => {
    var table = req.params.table;
    var field = req.params.field;
    var value = req.params.value;
    pool.query(`SELECT * FROM ${table} WHERE ${field}='${value}'`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// GET RECORDS WITH LIKE
app.get('/like/:table/:field/:value', tokencheck(), (req, res) => {
    var table = req.params.table;
    var field = req.params.field;
    var value = req.params.value;
    pool.query(`SELECT * FROM ${table} WHERE ${field} LIKE '%${value}%'`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.length} records sent form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// INSERT RECORD
app.post('/:table', tokencheck(), (req, res) => {
    var table = req.params.table;
    var records = req.body;
    var str = 'null';
    var str2 = 'ID';

    var fields = Object.keys(records);
    var values = Object.values(records);

    values.forEach(value => {
        str += ",'" + value + "'"
    })

    fields.forEach(field => {
        str2 += "," + field
    })

    pool.query(`INSERT INTO ${table} (${str2}) VALUES(${str})`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record inserted to ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// UPDATE RECORD
app.patch('/:table/:id', tokencheck(), (req, res) => {
    var table = req.params.table;
    var id = req.params.id;
    var records = req.body;
    var str = '';

    var fields = Object.keys(records);
    var values = Object.values(records);

    for (let i = 0; i < fields.length; i++) {
        str += fields[i] + "='" + values[i] + "'";
        if (i != fields.length - 1) {
            str += ",";
        }
    }

    pool.query(`UPDATE ${table} SET ${str} WHERE ID=${id}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record updated in ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// DELETE ALL RECORDS
app.delete('/:table', tokencheck(), (req, res) => {
    var table = req.params.table;
    pool.query(`DELETE FROM ${table}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record deleted form ${table} table.`);
            res.status(200).send(results);
        }
    });
});

// DELETE ONE RECORD
app.delete('/:table/:field/:value', tokencheck(), (req, res) => {
    var table = req.params.table;
    var field = req.params.field;
    var value = req.params.value;

    pool.query(`DELETE FROM ${table} WHERE ${field}=${value}`, (err, results) => {
        if (err) {
            log(req.socket.remoteAddress, err);
            res.status(500).send(err);
        } else {
            log(req.socket.remoteAddress, `${results.affectedRows} record deleted form ${table} table.`);
            res.status(200).send(results);
        }
    });
});


app.listen(port, () => {
    log('SERVER', `Listening started on port ${port}.`);
})

// MIDDLEVARE FUNCTIONS

function tokencheck() {
    return (req, res, next) => {
        if (req.headers.authorization == token) {
            next();
        } else {
            res.status(500).json({ message: 'Illetéktelen hozzáférés!' });
        }
    };
}

function log(req, res) {
    if (debug == 1) {
        var timestamp = moment(new Date()).format('yyyy-MM-DD HH:mm:ss');
        console.log(`[${timestamp}] : ${req} >>> ${res}`);
    }
}