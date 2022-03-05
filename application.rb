require "csv"
require_relative "functions"

arquivo_dengue = '/home/intersol/Documentos/Projetos/av1_mat/dados/Base de Dengue0.csv'
arquivo_onibus = '/home/intersol/Documentos/Projetos/av1_mat/dados/Base de Onibus0.csv'
arquivo_alunos = '/home/intersol/Documentos/Projetos/av1_mat/dados/Base de Alunos0.csv'

dados_dengue = formata_arquivo_para_array(arquivo_dengue)
dados_onibus = formata_arquivo_para_array(arquivo_onibus)
dados_alunos = formata_arquivo_para_array(arquivo_alunos)

relatorio1 = relatorio_alunos_sem_dengue(dados_alunos, dados_dengue)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Genero", "Data de Nascimento"], "relatorio1.csv", relatorio1)

relatorio2 = relatorio_dengue_sem_onibus(dados_dengue, dados_onibus)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Sexo", "Data de Nascimento", "Data da dengue"], "relatorio2.csv", relatorio2)

relatorio3 = relatorio_onibus_sem_dengue(dados_onibus, dados_dengue)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Genero", "Data de Nascimento", "onibus"], "relatorio3.csv", relatorio3)

relatorio4 = relatorio_alunos_com_dengue(dados_alunos, dados_dengue)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Genero", "Data de Nascimento"], "relatorio4.csv", relatorio4)

relatorio5 = relatorio_alunos_que_utilizam_onibus(dados_onibus, dados_alunos)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Genero", "Data de Nascimento", "onibus"], "relatorio5.csv", relatorio5)

relatorio6 = relatorio_dengue_com_onibus(dados_dengue, dados_onibus)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Sexo", "Data de Nascimento", "Data da dengue"], "relatorio6.csv", relatorio6)

relatorio7 = relatorio_aluno_com_dengue_e_com_onibus(dados_alunos, dados_dengue, dados_onibus)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Genero", "Data de Nascimento"], "relatorio7.csv", relatorio7)

relatorio8 = relatorio_dengue_sem_onibus(dados_dengue, dados_onibus)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Sexo", "Data de Nascimento", "Data da dengue"], "relatorio8.csv", relatorio8)

relatorio9 = relatorio_dengue_sem_alunos(dados_dengue,dados_alunos)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Sexo", "Data de Nascimento", "Data da dengue"], "relatorio9.csv", relatorio9)

relatorio10 = relatorio_dengue_sem_escola_sem_onibus(dados_dengue, dados_alunos, dados_onibus)
cria_csv_com_cabecalhos(["id", "Nome", "Nome pai", "Nome mãe", "Sexo", "Data de Nascimento", "Data da dengue"], "relatorio10.csv", relatorio10)
