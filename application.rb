require "csv"
require_relative "functions"

arquivo_dengue = '/home/intersol/Documentos/Projetos/av1_mat/dados/Base de Dengue0.csv'
arquivo_onibus = '/home/intersol/Documentos/Projetos/av1_mat/dados/Base de Onibus0.csv'
arquivo_alunos = '/home/intersol/Documentos/Projetos/av1_mat/dados/Base de Alunos0.csv'

dados_dengue = formata_arquivo_para_array(arquivo_dengue)
dados_onibus = formata_arquivo_para_array(arquivo_onibus)
dados_alunos = formata_arquivo_para_array(arquivo_alunos)

puts relatorio_alunos_sem_dengue(dados_alunos, dados_dengue).size
puts relatorio_dengue_sem_onibus(dados_dengue, dados_onibus).size

puts relatorio_onibus_sem_dengue(dados_onibus, dados_dengue).size
puts relatorio_alunos_com_dengue(dados_alunos, dados_dengue).size

puts relatorio_alunos_que_utilizam_onibus(dados_onibus, dados_alunos).size
puts relatorio_dengue_com_onibus(dados_dengue, dados_onibus).size