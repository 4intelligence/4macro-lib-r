% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_multi_series.R
\name{get_multi_series}
\alias{get_multi_series}
\title{Busca de informações de uma ou mais séries}
\usage{
get_multi_series(base_parameters, ...)
}
\arguments{
\item{base_parameters}{Data Frame, obrigatóriamente, com todos os parâmetros necessários para a API funcionar. Os parâmetros são datalhados no teim details desta documentação}

\item{...}{Parâmetros adicionais: \code{filepath} String com caminho para o arquivo \code{.ini} de autenticação; \code{lang} (Opcional) String com a língua definida para as respostas das séries}
}
\value{
O retorno consiste em uma lista contendo seis campos: series, names, short_names, content, last_actual e status, respectivamente.
Dentro de cada campo haverá uma outra lista, em que cada posição representa uma informação das séries
consultadas, respeitando a ordem de entrada. O campo names contém o nome longo de cada série, content
contém um data frame com as observações, last_actual a última data da observação realizada e status indica
se a série foi consultada com sucesso. Os
possíveis valores para status são:

\item{0}{Dados consultados com sucesso;}
\item{1}{Erro no formato da requisição;}
\item{2}{Parâmetro usr não está no formato correto;}
\item{3}{Parâmetro pwd não está no formato correto;}
\item{4}{Código da série não está no formato correto;}
\item{12}{Erro de autenticação com os parâmetros do usuário;}
\item{13}{Série não está disponível para o usuário;}
\item{14}{O parâmetro series deve ser uma lista.}
}
\description{
Função que busca dados de uma ou mais séries
}
\details{
Primeiramente é necessário salvar as suas credenciais em um arquivo \code{.ini} ou \code{.Renviron}
Para gerar um arquivo de autenticação utilize a função \code{generate_ini} ou \code{generate_r_environ}
É altamente recomendável utilizar o \code{.Renviron} como seu arquivo de autenticação.

Para criar um arquivo de autenticação utilize a função \code{generate_r_environ} ou \code{generate_ini}

Os parâmetros da consulta devem ser passados como um dataframe.
O Data Frame de consulta deve ter obrigatóriamente os seguintes campos:

\itemize{
\item{sid: }{Obrigatório. Códigos de 16 dígitos das séries que deseja consultar;}
\item{label: }{Opcional. String com nome da projeção, obrigatório somente para dados projetados;}
\item{estimate: }{Opcional. Logical TRUE se são dados projetados, para dados realizados FALSE;}
\item{force: }{Opcional. Se TRUE força a geração do conteúdo da resposta com a propriedade label mesmo
 que exista nenhuma ou apenas um segmento estimado. Vale FALSE se não for especificado;}
\item{reff: }{Opcional. Retornar datas de referência para as observações caso TRUE, ou a data original informada pela fonte primária ou gerada pelo algoritmo de estimativa FALSE;}
\item{start: }{Opcional. String com data para inicio dos dados da série a serem requisitados;}
\item{end: }{Opcional. String com data limite das informações da série;}
}

O arquivo de autenticação \code{.Renviron} deverá conter os seguintes campos:
\itemize{
\item{URL_4MACRO }{Url base de acesso ao servidor}
\item{USR_4MACRO }{Id do usuário}
\item{PWD_4MACRO }{Senha do usuário}
}

DEPRECATED
O arquivo de autenticação \code{.ini} deve conter uma única seção com o nome \code{login}, incluindo o
seguintes campos:

\itemize{
\item{url: }{Url base de acesso ao servidor;}
\item{usr: }{Id do usuário;}
\item{pwd: }{Senha do usuário.}
}
}
\examples{

\dontrun{
# Utilizando um arquivo .ini
query_data <- data.frame(
 sid = c('BRGDP0002000ROQL', 'BRGDP0021000ROQL'), 
 label = c(NA, "Estimativa 2020-01-02"),
 estimate = c(TRUE, TRUE),
 force = c(FALSE, FALSE),
 reff = c(TRUE, FALSE)
)

get_multi_series(query_data, filepath = "/home/samuel/auth.ini", lang = "pt-br")

# Utilizando variáveis de ambiente
query_data <- data.frame(
	sid = c('BRGDP0002000ROQL'),
	label = c(NA),
	estimate = c(TRUE),
	force = c(FALSE),
	reff = c(TRUE)
)

get_multi_series(query_data)

}

}
\author{
Gustavo Marins Bitencourt

Samuel Souza
}
