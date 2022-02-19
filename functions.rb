def formata_arquivo_para_array(arquivo)
  dados = Array.new

  CSV.foreach(arquivo, col_sep: ';', :encoding => 'windows-1251:utf-8') do |row|
    dados << row
  end
  dados.shift

  return dados
end

def compara_strings_formatadas(string1, string2)
  string1_formatado = string1.split(" ")
  string2_formatado = string2.split(" ")

  if string1.size == string2.size
    if string1 == string2
      string1_formatado.each_with_index do |string, index|
        return false if string1_formatado[ index ][ index ] != string2_formatado[ index ][ index ]
      end
      return true
    end
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

  def loop_de_comparacao_tripla_de_dados(dados_principais, dados_secundarios ,dados_terciarios ,loop_de_exclusao_secundario, loop_de_exclusao_terciario)
    dado_formatado = Array.new

    dados_principais.each do |dado_principal|
      condicao_secundaria_atendida, condicao_terciaria_atendidada = false

      dado_secundario_formatado,dado_terciario_formatado = nil

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
            condicao_secundaria_atendida = true
            break
          else
            dado_terciario_formatado = dado_terciario
          end
        end
      end

      if dado_secundario_formatado != nil && dado_terciario_formatado != nil
        dado_formatado << dado_principal
      end
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




