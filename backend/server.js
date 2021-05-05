const express = require('express');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 5000;

const MongoClient = require('mongodb').MongoClient;
const uri = "mongodb+srv://ConectePet:C317ConectePet@clusterc317.bnkbh.mongodb.net/ConectePet?retryWrites=true&w=majority";
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

app.use(cors({
  origin: '*',
  credentials: true,
})
);
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.get('/pets/:email', (req, res) => {
  var response;
  const collection = client.db("ConectePet").collection("Pet");    
  collection.find({usuario: req.params.email}).toArray(function(err, result) {
    if (err) throw err;
    response=result;
    res.send({ express: response });
  });   
  
});

app.get('/login/:email/:senha', (req, res) => {
  var response;
  const collection = client.db("ConectePet").collection("Usuario");    
  collection.find({email: req.params.email, senha: req.params.senha}).toArray(function(err, result) {
    if (err) throw err;
    response=result;
    res.send({ express: response });
  });   
  
});

app.get('/vacinas/registro/:email', (req, res) => {
  var response;
  const collection = client.db("ConectePet").collection("Pet");    
  collection.find({usuario: req.params.email}).toArray(function(err, result) {
    if (err) throw err;
    response=result;
    res.send({ express: response });
  });   
  
});

app.post('/pet/cadastro', (req, res) => {
  const collection = client.db("ConectePet").collection("Pet");
  collection.insertOne(req.body);
  res.end();
});

app.post('/vacinas/registro', (req, res) => {
  const collection = client.db("ConectePet").collection("Vacinas");    
  collection.insertOne(req.body);
  res.end();
});

app.post('/usuario/cadastro', (req, res) => {
  const collection = client.db("ConectePet").collection("Usuario");
  collection.insertOne(req.body);
  res.end();
});

app.post('/consultas/agendamento', (req, res) => {
  const collection = client.db("ConectePet").collection("Consultas");    
  collection.insertOne(req.body);
  res.end();
});

client.connect();
app.listen(port, () => console.log(`Listening on port ${port}`));