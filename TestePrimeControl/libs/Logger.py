import logging

from robot.output import librarylogger
from robot.running.context import EXECUTION_CONTEXTS
from datetime import datetime


def write(msg, level='INFO', html=False):
    if EXECUTION_CONTEXTS.current is not None:
        librarylogger.write(msg, level, html)
    else:
        logger = logging.getLogger("RobotFramework")
        level = {'DEBUG': logging.DEBUG,
                 'INFO': logging.INFO,
                 'ERROR': logging.ERROR}[level]
        logger.log(level, msg)
    writeLogRobot(msg, level)


def log_debug(msg, html=False, also_console=True):
    write(msg, 'DEBUG', html)
    if also_console:
        log_console("\n *** [LOG DEBUG] *** " + msg)


def log_info(msg, html=False, also_console=True):
    write(msg, 'INFO', html)
    if also_console:
        log_console("\n *** [LOG INGO] *** " + msg)

def log_error(msg, html=False, also_console=True):
    write(msg, 'ERROR', html)
    if also_console:
        log_console("\n *** [LOG ERROR] *** " + msg)

def log_console(msg, newline=True, stream='stdout'):
    librarylogger.console(msg, newline, stream)

def writeLogRobot(str, typeLog):
    try:
        with open('../log/log.txt', 'a') as arquivo:
            data_e_hora_atuais = datetime.now()
            data_e_hora_em_texto = data_e_hora_atuais.strftime('%d/%m/%Y %H:%M')
            arquivo.write(data_e_hora_em_texto + " - " + typeLog + " -> " + str + "\n")
    except:
        print('Falha ao gravar no log do robot')