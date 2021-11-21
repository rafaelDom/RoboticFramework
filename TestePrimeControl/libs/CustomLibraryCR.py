import requests
import json
import re
from urllib.parse import quote
import pandas as pd
from objdict import ObjDict
from robot.output import logger
import Logger


#Recebe o token e o nome do país e retorno o id do pais
def get_id_localization(auth, pais):
    Logger.log_info("Function get_id_localization()")
    auth = "Bearer " + auth
    Logger.log_info("Authorizacao para API: " + auth)
    Logger.log_info("País para o filtro: " + pais)

    try:
        res = requests.get("https://api.clashroyale.com/v1/locations", headers={"Accept":"application/json","authorization":auth})
        objJson = res.json()["items"]
    except:
        Logger.log_error("Falha ao requisar as localidades para API do Clash Royale")
        return False
  
    for item in objJson:
        if(item["name"] == pais):
            Logger.log_debug("País encontrado")
            return item["id"] 

    return False


#Recebe o token, name, id da localizacao, inicio da tag do clã e retorna as informacoes do clã
def get_info_cla(auth, name, locationId, iniTag):
    Logger.log_info("Function get_info_cla()")
    auth = "Bearer " + auth
    Logger.log_info("auth: " + auth)
    Logger.log_info("auth: " + name)
    Logger.log_info("locationId: " + str(locationId))
    Logger.log_info("iniTag: " + iniTag)

    try:
        res = requests.get("https://api.clashroyale.com/v1/clans?", headers={"Accept":"application/json","authorization":auth}, params={"name":name, "locationId":locationId})
        objJson = res.json()["items"]
    except:
        Logger.log_error("Falha ao requisar as informacoes do cla para API do Clash Royale")
        return False

    for item in objJson:
        iniTagResult = re.match(iniTag, item["tag"])
        if(iniTagResult):
            infosCla = json.dumps(item)
            Logger.log_debug("Informações encontradas: " + infosCla)
            return infosCla 
        
    return False


#Recebe a auth e as informações do clã e retorna a lista de membros do clã
def get_member_list_cla(auth, informacoesCla):
    Logger.log_info("Function get_member_list_cla()")
    auth = "Bearer " + auth
    Logger.log_info("auth: " + auth)
    Logger.log_info("informacoesCla: " + informacoesCla)

    try:
        infosCla = json.loads(informacoesCla)
        paramTag = quote(infosCla["tag"] )
        res = requests.get("https://api.clashroyale.com/v1/clans/" + paramTag + "/members", headers={"Accept":"application/json","authorization":auth})
        objJson = res.json()["items"]
    except:
        Logger.log_error("Falha ao requisar a lista de membros do cla para API do Clash Royale")
        return False

    return json.dumps(objJson)


#Escreve no csv os dados
def write_csv(dados, csv_file):
    Logger.log_info("Function write_csv()")
    Logger.log_info("dados: " + dados)

    dados = json.loads(dados)
    try:
        listaDataJson = []
        for item in dados:
            data = {}
            data['name'] = item['name']
            data['expLevel'] = item['expLevel']
            data['trophies'] = item['trophies']
            data['role'] = item['role']
            listaDataJson.append(data)
            dados = json.dumps(listaDataJson)

        df = pd.read_json(dados)
        df.to_csv(csv_file, index = None)
    except:
        Logger.log_error("Falha ao gravar dados no csv")
        return False

    return True
