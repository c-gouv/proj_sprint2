var complexoModel = require("../models/complexoModel");

function buscarComplexosPorEmpresa(req, res) {
  var empresaId = req.params.empresaId;

  complexoModel.buscarComplexosPorEmpresa(empresaId).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os dados: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function buscarComplexoPorId(req, res) {
  var complexoId = req.params.complexoId;

  complexoModel.buscarComplexoPorId(complexoId).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os dados: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function silosEmAlerta(req,res){
  var complexoId = req.params.complexoId;

  complexoModel.silosEmAlerta(complexoId).then((resultado) => {
    if(resultado.length > 0) {
      res.status(200).json(resultado);
    }else{
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os dados: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function siloMaisCritico(req,res){
  var complexoId = req.params.complexoId;

  complexoModel.siloMaisCritico(complexoId).then((resultado) => {
    if(resultado.length > 0) {
      res.status(200).json(resultado);
    }else{
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os dados: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}

function temperaturaUmidadeMedia(req,res){
  var complexoId = req.params.complexoId;

  complexoModel.temperaturaUmidadeMedia(complexoId).then((resultado) => {
    if(resultado.length > 0) {
      res.status(200).json(resultado);
    }else{
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os dados: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


function cadastrar(req, res) {
  var descricao = req.body.descricao;
  var idUsuario = req.body.idUsuario;

  if (descricao == undefined) {
    res.status(400).send("descricao está undefined!");
  } else if (idUsuario == undefined) {
    res.status(400).send("idUsuario está undefined!");
  } else {


    complexoModel.cadastrar(descricao, idUsuario)
      .then((resultado) => {
        res.status(201).json(resultado);
      }
      ).catch((erro) => {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

module.exports = {
  buscarComplexosPorEmpresa,
  buscarComplexoPorId,
  silosEmAlerta,
  siloMaisCritico,
  temperaturaUmidadeMedia,
  cadastrar
}