def formata_arquivo_para_array(arquivo)
  dados = Array.new

  CSV.foreach(arquivo, col_sep: ';', :encoding => 'windows-1251:utf-8') do |row|
    dados << row
  end
  dados.shift

  return dados
end

def cria_csv_com_cabecalhos(cabecalhos, arquivo, dados)
  CSV.open(arquivo, "w") do |csv|
    csv.to_io.write "\uFEFF"
    csv << cabecalhos
    dados.each do |dado|
      #puts dado
      csv << dado
    end
  end
end

def compara_strings_formatadas(string1, string2)
  string1_formatado = string1.split(" ")
  string2_formatado = string2.split(" ")
  #Separa cada nome da pessoa em um array
  return true if string1_formatado[1] == string2_formatado[1] && string1_formatado[2] == string2_formatado[2]
  # compara se os sobrenomes são os mesmos

  if string1 != string2 && string1_formatado.size == string2_formatado.size
    string1_formatado.each_with_index do |string, index|
      nome1 = string1_formatado[ index ]
      nome2 = string2_formatado[ index ]
      #pego o nome de cada pessoa

      if nome1 != nil && nome2 != nil
        return false if nome1[ index ] != nome2[ index ]
        #compara a inicial de cada nome
      else
        return false
      end
    end
    return true
  end

  return string1 == string2
end

def compara_nomes(nome1, nome2)
  compara_strings_formatadas(nome1, nome2)
end

def compara_pais(pai1, pai2)
  compara_strings_formatadas(pai1, pai2)
end

def compara_maes(mae1, mae2)
  compara_strings_formatadas(mae1,mae2)
end

def eh_a_mesma_pessoa?(nome1, nome2, pai1, pai2, mae1, mae2)
  compara_nomes(nome1, nome2) && ( compara_pais(pai1, pai2) || compara_maes(mae1, mae2) )
end

def loop_de_comparacao_dupla_de_dados(dados_principais, dados_comparativos, loop_de_exclusao)
  dado_formatado = Array.new

  condicao_atendida = false
  dados_principais.each do |dado_principal|
    condicao_atendida = false
    dados_comparativos.each do |dado_comparativo|
      if eh_a_mesma_pessoa?( dado_principal[1], dado_comparativo[1], dado_principal[3], dado_comparativo[3], dado_principal[2], dado_comparativo[2] )
        if loop_de_exclusao
          condicao_atendida = true
          break
        else
          dado_formatado << dado_principal
          break
        end
      end
    end
    if condicao_atendida == false && loop_de_exclusao
      dado_formatado << dado_principal
    end
  end
  return dado_formatado
end

def loop_de_comparacao_tripla_de_dados(dados_principais, dados_secundarios ,dados_terciarios ,loop_de_exclusao_secundario, loop_de_exclusao_terciario)
  dado_formatado = Array.new

  dados_principais.each do |dado_principal|
    condicao_secundaria_atendida = false
    condicao_terciaria_atendidada = false

    dado_secundario_formatado = nil
    dado_terciario_formatado = nil

    dados_secundarios.each do |dado_secundario|
      if eh_a_mesma_pessoa?( dado_principal[1], dado_secundario[1], dado_principal[3], dado_secundario[3], dado_principal[2], dado_secundario[2] )
        if loop_de_exclusao_secundario
          condicao_secundaria_atendida = true
          break
        else
          dado_secundario_formatado = dado_secundario
        end
      end
    end

    dados_terciarios.each do |dado_terciario|
      if eh_a_mesma_pessoa?( dado_principal[1], dado_terciario[1], dado_principal[3], dado_terciario[3], dado_principal[2], dado_terciario[2] )
        if loop_de_exclusao_terciario
          condicao_terciaria_atendidada = true
          break
        else
          dado_terciario_formatado = dado_terciario
        end
      end
    end
    if dado_secundario_formatado != nil && dado_terciario_formatado != nil
      dado_formatado << dado_principal
    elsif loop_de_exclusao_secundario && loop_de_exclusao_terciario && condicao_secundaria_atendida == false && condicao_terciaria_atendidada == false
      dado_formatado << dado_principal
    end
  end
  return dado_formatado
end

def relatorio_alunos_sem_dengue(dados_alunos, dados_dengue)
  loop_de_comparacao_dupla_de_dados(dados_alunos, dados_dengue, true)
end

def relatorio_dengue_sem_onibus(dados_dengue, dados_onibus)
  loop_de_comparacao_dupla_de_dados(dados_dengue, dados_onibus, true)
end

def relatorio_onibus_sem_dengue(dados_onibus, dados_dengue)
  loop_de_comparacao_dupla_de_dados(dados_onibus, dados_dengue, true)
end

def relatorio_alunos_com_dengue(dados_alunos, dados_dengue)
  loop_de_comparacao_dupla_de_dados(dados_alunos, dados_dengue, false)
end

def relatorio_alunos_que_utilizam_onibus(dados_onibus, dados_alunos)
  loop_de_comparacao_dupla_de_dados(dados_onibus, dados_alunos, false)
end

def relatorio_dengue_com_onibus(dados_dengue, dados_onibus)
  loop_de_comparacao_dupla_de_dados(dados_dengue, dados_onibus, false)
end

def relatorio_aluno_com_dengue_e_com_onibus(dados_alunos, dados_dengue, dados_onibus)
  loop_de_comparacao_tripla_de_dados(dados_alunos, dados_dengue, dados_onibus, false , false)
end

def relatorio_dengue_sem_escola_sem_onibus(dados_dengue, dados_alunos, dados_onibus)
  loop_de_comparacao_tripla_de_dados(dados_dengue, dados_alunos, dados_onibus, true , true)
end

def relatorio_dengue_sem_alunos(dados_dengue,dados_alunos)
  loop_de_comparacao_dupla_de_dados(dados_dengue, dados_alunos, true)
end




