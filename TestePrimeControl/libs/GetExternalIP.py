import requests
import Logger

# Funcao requisita url para pegar o ip externo, caso de algum erro, seta por padrao o ip passado por parametro
def get_external_ip(ip_padrao):
    Logger.log_info('get_external_ip()')
    try:
       ip = requests.get('https://checkip.amazonaws.com').text.strip()
       Logger.log_debug('O IP externo capturado e: ' + ip)
    except:
        ip = ip_padrao
        Logger.log_error('Falha ao requisitar o https://checkip.amazonaws.com para obter o ip externo')

    return ip


