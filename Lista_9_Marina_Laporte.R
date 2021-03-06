## An�lise de Dados - Lista 9 
## Marina Laporte Cotias 

## Quest�o 1

## a) Voc� est� confiante de que a correla��o entre Zi e Xi � zero 

## Sendo zi e xi totalmente independentes, ou seja, a correla��o entre eles � zero, em que ambas vari�veis 
## afetam Yi, podemos omitir com seguran�a a vari�vel Zi sem que essa interfira no coeficiente estimado do 
## modelo. Por�m, nesse caso as conclus�es da vari�vel dependente estar�o distorcidas. 

## b) Voc� acha que a correla��o entre Zi e Xi � positiva 

## Sendo Xi e Zi correlacionados, no qual ambas apresentam efeito na Yi, caso a vari�vel Zi seja omitida 
## o termo de polariza��o n�o ser� igual a zero. Com isso, omitindo essa vari�vel, o efeito de Xi em Yi estar�
## sendo estimado de forma errada (poluindo esse efeito). � necess�rio controlar por Zi, para se obter uma estimativa 
## imparcial do efeito de Xi. Quando n�o inclu�da a vari�vel Zi, temos um problema de vi�s de vari�vel omitida, quando 
## o valor esperado da estimativa do par�metro que obtemos da amostra n�o ser� igual ao par�metro real verdadeiro. 
## Podemos an�lisar a magnitude desse vi�s. Se no modelo incluindo Zi, o coeficientes de Xi e Zi forem positivos, isso 
## significa que em um modelo em que a vari�vel Zi for omitida, o coeficiente de Xi ser� maior do que deveria. Isso acontece 
## pois, um n�mero positivo mais o produto de dois n�meros positivos, ter� como resultado um n�mero positivo maior, ou seja, 
## um coeficiente superestimado. 

## Voc� acha que a correla��o entre Zi e Xi � negativa

## Caso a correla��o entre Zi e Yi seja negativa e Zi tenha um efeito negativo em Yi, o coeficiente estimado de Xi, sem incluir 
## o Zi no modelo, ser� maior do que deveria, pois um n�mero negativo mais o produto de um n�mero negativo com um positivo 
## ter� como resultado um n�mero negativo maior, ou seja, um coeficiente superestimado.

## Quest�o 2 

## Resultados da tabela 9.4 (analisando as colunas A e B)

## Na coluna A, os resultados mostram, que um aumento de 1 unidade na porcentagem de residentes do estado com um diploma 
## universit�rio, espera-se um aumento de 704.02 no sal�rio dos professores. Esse efeito � significativo (p-valor<0.05) 
## e com um erro padr�o de 140.22. Caso a vari�vel da porcentagem dos residentes com diploma for zero, espera-se que 
## que o sal�rio dos professores seja 2.8768,01, com um erro padr�o de 3913.27. Esse efeito � significativo (p-valor<0.05). 
## Na coluna B, os resultados mostram, que com um aumento de 1 unidade na renda per capita, espera-se um aumento de 0.68 
## no sal�rio dos professores. Esse efeito � significativo, com um erro padr�o de 0.11. Caso a vari�vel renda per capita 
## fosse zero, espera- se que o sal�rio dos professores seja 2.1168,11. Esse efeito � significativo com um erro padr�o 
## de 4102.40. 

## Quest�o 3 

## Analisando a coluna C � poss�vel observar que com aumento de 1 unidade na porcentagem de residentes com diploma 
## universit�rio, espera-se um aumento de 24.58 no sal�rio dos professores, controlando pela renda per capita. 
## Nesse modelo, a vari�vel da porcentagem de residentes com diploma, passou a ser n�o-significativa e teve uma diminui��o 
## substancial. J� a vari�vel renda per capita, no contexto multivariado, permaneceu quase inalterada, controlando
## pela porcentagem de residentes com diploma, com um efeito de 0.66. Al�m disso, em rela��o a capacidade explicativa 
## do modelo, o R2 da coluna C em rela��o a coluna A, tem uma maior capacidade explicativa do modelo. J� em rela��o ao 
## modelo da coluna B, o R2 permaneceu inalterado. 

## Quest�o 4 

## 4.1 

## Definir diret�rio 

setwd('C:/Users/usuario/Desktop/lista 9 dados')

## Ler arquivo em txt 

bd <- read.delim('wordrecall.txt')

## Modelo 1 

reg <- lm(prop ~ time, data = bd)

summary(reg)

## Pressusposto de linearidade 

## Gr�fico de dispers�o ajustado 

library(ggplot2)

ggplot(data = bd, aes(y = prop, x = time)) + geom_point(color = "blue") + 
theme_classic() + geom_smooth(method = "lm", color = "black", se = FALSE) + 
geom_label(aes(x = 7000, y = 0.6), hjust = 0, 
label = paste("Adj R2 = ",signif(summary(reg)$adj.r.squared, 2),
 " \nP =",signif(summary(reg)$coef[2,4], 2)))


## Gr�fico dos res�duos versus valores ajustados 

ggplot(lm(reg)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0)

## Gr�fico de normalidade 

shap <- shapiro.test(reg$residuals)

ggplot(data = bd, aes(sample = reg$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 0.4), hjust = 0, 
label = paste ("shapiro.test =",signif(summary(shap$p.value)[3], 5)))

## rmse modelo 1 

rmse <- function(x){
        sqrt(mean(x^2))  
}

rmse(reg$residuals)


## Modelo 2: level-log 

reg2 <- lm(prop ~ log(time), data = bd)

summary(reg2)

## Fun��o de logar�timo natural 

bd$lntime <- log(bd$time) 

## Gr�fico de dispers�o com  x = ln.time 

ggplot(data = bd, aes(y = prop, x = bd$lntime)) + geom_point(color = "blue") + 
theme_classic() + geom_smooth(method = "lm", color = "black", se = FALSE) +
geom_label(aes(x = 6, y = 0.8), hjust = 0, 
label = paste("Adj R2 = ",signif(summary(reg2)$adj.r.squared, 2),
" \nP =",signif(summary(reg2)$coef[2,4], 2)))

## Gr�fico dos res�duos versus valores ajustados com x = line.time 

ggplot(lm(reg2)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0)

## RMSE modelo 2

rmse(reg2$residuals)

## Gr�fico de normalidade 

shap2 <- shapiro.test(reg2$residuals)

ggplot(data = bd, aes(sample = reg2$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 0.1), hjust = 1, 
label = paste ("shapiro.test =",signif(summary(shap2$p.value)[3], 2)))

## a) Analisando o ajuste, o modelo 1 apresenta um erro padr�o residual de 0.15, o que indica  que a m�dia da 
## amostra se desvia em 0.15 das poss�veis m�dias amostrais. RMSE foi de 0.14. Isso indica que o modelo desvia 
## em m�dia 0.14 pontos ao prever a propor��o de itens corretamente lembrados.O gr�fico de dispers�o do modelo 1, 
## sugere que a propor��o de itens recuperados n�o est� linearmente relacionada com o tempo. O gr�fico dos res�duos 
## versus os valores ajustados, tamb�m sugere um relacionamento n�o-linear entre as vari�veis. Como o modelo n�o � 
## linear, n�o � poss�vel avaliar se as vari�ncias do erro s�o iguais. Analisando o gr�fico da normalidade dos erros
## � poss�vel ver que os pontos est�o pr�ximos a linha o que sugere evid�ncias de que a distribui��o dos erros � 
## normal. Al�m disso, o teste de Shapiro indica que n�o podemos rejeitar a hip�tese nula de que a distribui��o 
## dos erros � normal. Como o �nico problema do conjunto de dados � a n�o-linearidade, foi feita uma transforma��o 
## logar�timica no valor do preditor (linear-log). Com isso, os resultados mostram que 1% na varia��o do tempo, em minutos, desde 
## que a lista foi memorizada, implica em -0.00079 de varia��o na propor��o de itens corretamente lembrados, com um p-valor significativo.  
## Em rela��o ao ajuste, o modelo 1 apresenta um erro padr�o residual maior (0.15), do que o modelo 2 (0.023).Isso significa, 
## que no segundo modelo, a dist�ncia m�dia entre os pontos do modelo e a reta de regress�o � maior e com isso menos ajustado. 
## O RMSE do modelo 2 � maior do que o modelo 1 (0.21 > 0.14). Isso indica que no segundo modelo os pontos dos dados observados 
## est�o mais pr�ximos dos valores preditos, do que o primeiro modelo. Analisando os pressupostos, com a tranforma��o 
## da vari�vel independente, podemos observar que no gr�fico dos res�duos versus os valores ajustados, houve uma 
## melhoria significativa em rela��o ao dados n�o tranformados. Com isso, podemos afirmar com mais precis�o que o modelo 
## � homoced�stico, pois os pontos est�o distribu�dos aleatoriamente, n�o havendo nenhuma tend�ncia. No gr�fico de dispers�o 
## do modelo 2 � poss�vel ver que a tranforma��o level-log resolveu o problema da n�o-linearidade. O gr�fico da normalidade 
## do modelo 2, sugere que a distribui��o dos res�duos se aproxima de uma distribui��o normal. No teste de shapiro, o p-valor 
## foi de 0.59, ou seja, n�o significativo (tendo um par�metro de 0.05). Isso indica que n�o podemos rejeitar a hip�tese nula 
## de que a distribui��o dos erros � normal. Analisando a capacidade explicativa do modelo, o modelo 2 apresenta um R2 maior do que o 
## o modelo 1 (0.98>0.53) e com isso maior capacidade de explicar a varia��o na vari�vel dependente. 

## tranformando o valor de Y quando a n�o-linearidade � o �nico problema 

reg3 <- lm((prop^-1.25) ~ time, data = bd)

summary(reg3) 

## Fun��o de logar�timo natural 

bd$lnprop <- (bd$prop^-1.25)

## Gr�fico de dispers�o com y^1.25

ggplot(data = bd, aes(y = bd$lnprop, x = time)) + geom_point(color = "blue") + 
theme_classic() + geom_smooth(method = "lm", color = "black", se = FALSE) + 
geom_label(aes(x = 0, y = 20), hjust = 0, 
label = paste("Adj R2 = ",signif(summary(reg3)$adj.r.squared, 2),
" \nP =",signif(summary(reg3)$coef[2,4], 2)))


## Gr�fico dos res�duos versus valores ajustados com y^-1.25

ggplot(lm(reg3)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0)

## Gr�fico da normalidade dos erros 

shap3 <- shapiro.test(reg3$residuals)

ggplot(data = bd, aes(sample = reg3$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 2), hjust = 0, 
label = paste ("shapiro.test =",signif(summary(shap3$p.value)[3], 2)))

---------------------------------------------------------------------------------------------------------------------- 

## Definir diret�rio 

setwd('C:/Users/usuario/Desktop/lista 9 dados')

## Ler arquivo em txt 

bd2 <- read.delim('shortleaf.txt')

## modelo 4 

reg4 <- lm(Vol ~ Diam, data = bd2)

summary(reg4)

## Gr�fico de dispers�o modelo 4

ggplot(data = bd2, aes(y = Vol, x = Diam)) + geom_point(color = "blue") + 
theme_classic() + geom_smooth(method = "lm", color = "black", se = FALSE) + 
geom_label(aes(x = 0, y = 145), hjust = 0, 
label = paste("Adj R2 = ",signif(summary(reg4)$adj.r.squared, 5),
" \nP =",signif(summary(reg4)$coef[2,4], 5)))

## ## Gr�fico dos res�duos versus valores ajustados modelo 4 

ggplot(lm(reg4)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0) 

## Gr�fico da normalidade modelo 4 

shap4 <- shapiro.test(reg4$residuals)

ggplot(data = bd2, aes(sample = reg4$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 40), hjust = 0, 
label = paste ("shapiro.test =",signif(summary(shap4$p.value)[3], 2)))

  ### Um ponto de dados pode ser considerado um "outlier" 
  ### apenas por causa do efeito do ajuste fraco do modelo 

## RMSE modelo 4 

rmse(reg4$residuals)

### logar�timo natural dos di�metros das �rvores 

bd2$lnDiam <- log(bd2$Diam) 

## Modelo 5 level-log 

reg5 <- lm(Vol ~ log(Diam), data = bd2)

summary(reg5)

## Gr�fico de dispers�o x = lnDiam

ggplot(data = bd2, aes(y = Vol, x = bd2$lnDiam)) + geom_point(color = "blue") + 
theme_classic() + geom_smooth(method = "lm", color = "black", se = FALSE) + 
geom_label(aes(x = 0, y = 25), hjust = 0, 
label = paste("Adj R2 = ",signif(summary(reg5)$adj.r.squared, 5),
" \nP =",signif(summary(reg5)$coef[2,4], 5)))

## Transformar apenas os valores de X n�o alterou a linearidade. 

## Gr�fico dos res�duos versus valores ajustados modelo 5

ggplot(lm(reg5)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0) 

## O gr�fico de res�duos versus ajustes tamb�m ainda sugere uma rela��o n�o linear ...

## Gr�fico da normalidade modelo 5 

shap5 <- shapiro.test(reg5$residuals) 

ggplot(data = bd2, aes(sample = reg5$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 50), hjust = 0, 
label = paste ("shapiro.test =",signif(summary(shap5$p.value)[3], 2)))

## pouca melhoria na normalidade do erro 

## tranformar x sozinho n�o foi suficiente 

## RMSE Modelo 5

rmse(reg5$residuals)

### logar�timo natural do volume das �rvores 

bd2$lnVol <- log(bd2$Vol) 

## modelo 6 - Log-log 

reg6 <- lm(log(Vol) ~ log(Diam), data = bd2)

summary(reg6)

## Gr�fico de dispers�o x = lnDiam e y = lnVol

ggplot(data = bd2, aes(y = bd2$lnVol, x = bd2$lnDiam)) + geom_point(color = "blue") + 
theme_classic() + geom_smooth(method = "lm", color = "black", se = FALSE) + 
geom_label(aes(x = 1.5, y = 5), hjust = 0, 
label = paste("Adj R2 = ",signif(summary(reg6)$adj.r.squared, 5),
" \nP =",signif(summary(reg6)$coef[2,4], 5)))

## O gr�fico de res�duos versus ajustes fornece ainda mais evid�ncias de uma rela��o 
## linear entre lnVol e lnDiam 

## Gr�fico dos res�duos versus valores ajustados modelo 6

ggplot(lm(reg6)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0) 

## Mesmo parecendo que algum "afunilamento" exista, os res�duos negativos seguem a faixa 
## horizontal desejada.

## Gr�fico da normalidade modelo 6 

shap6 <- shapiro.test(reg6$residuals)

ggplot(data = bd2, aes(sample = reg6$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 0.8), hjust = 0, 
label = paste ("shapiro.test =",signif(summary(shap6$p.value)[3], 2)))

## RMSE Modelo 6

rmse(reg6$residuals)

## b) 

## Pressupostos 

## No modelo 4 � poss�vel observar que o gr�fico de dispers�o e o gr�fico de res�duos versus ajustes,
## sugerem um relacionamento n�o-linear entre o volume da �rvore e o di�metro. Com isso, n�o � poss�vel avaliar 
## se a vari�ncia dos erros s�o iguais. Al�m disso, os erros tamb�m n�o parecem normalmente distribu�dos.O teste de 
## Shapiro para esse modelo foi significativo, o que sugere que podemos rejeitar a hip�tese nula de que a a 
## distribui��o dos erros � normal. Transformando apenas o valor de x em log (modelo level-log), vemos que 
## no gr�fico de dispers�o a rela��o continua n�o-linear. O gr�fico de res�duos versos valores ajustados 
## tamb�m ainda sugere uma rela��o n�o-linear. Por �ltimo no gr�fico da normalidade � poss�vel observar pouca 
## melhoria na normalidade dos res�duos e um teste de Shapiro ainda com um p-valor significativo. Em suma, a 
## transforma��o apenas dos valores de x n�o alterou a n�o-linearidade. Transformando tamb�m os valores de resposta
## (modelo log-log), observamos que a rela��o entre log do di�metro e o log do volume parece linear. O gr�fico dos 
## valores ajusatdos versus res�duos, tamb�m fornecem evid�ncias de uma rela��o linear. Al�m disso � poss�vel observar 
## que os pontos est�o mais "espalhados" com a tranforma��o, o que indica maiores evid�ncias para um modelo homoced�stico. 
## Por �ltimo, o gr�fico da probabilidade normal melhorou substancialmente, se ajustando melhor a reta. O teste de 
## Shapiro foi n�o-significativo, o que sugere que podemos n�o rejeitar a hip�tese nula de que os erros est�o distribu�dos 
## normalmente. Em suma, o modelo log-log funcionou melhor do que o modelo log-level. Existem fortes evid�ncias, de que 
## o relacionamento � linear entre as vari�veis, os termos dos erros s�o independentes e normalmente distribu�dos 
## com varia��es iguais (homoced�stico). 

## Resultados do modelo 

## Analisando o ajuste, o modelo 4 apresenta um erro padr�o residual de 9.87, o que indica que a m�dia da amostra se desvia 
## em 9.87 das poss�veis m�dias amostrais. RMSE foi de 9.73. Isso indica que o modelo desvia em m�dia 9.73 pontos ao prever a 
## dura��o da gesta��o. Os resultados do modelo 6 (transforma��o log-log), mostram que 1% na varia��o do di�metro  dos 
## pinheiros, implica em 2.56% de varia��o no volume em p�s c�bicos, com um p-valor significativo. Comparando os resultados 
## do modelo log-log (modelo 6) com o modelo 4, em rela��o ao ajuste, esse �ltimo apresenta um erro padr�o residual maior 
## (0.89), do que o modelo 1 (0.17).Isso significa, que no quarto modelo, a dist�ncia m�dia entre os pontos do modelo e 
## a reta de regress�o � maior e com isso menos ajustado do que o modelo log-log.  O RMSE do modelo tamb�m 4 � maior do que o 
## modelo 6 (9.73 > 0.16). Isso indica que no sexto modelo os pontos dos dados observados est�o mais pr�ximos dos valores preditos, 
## do que o quarto modelo. Analisando a capacidade explicativa do modelo, o modelo 6 apresenta um R2 ajustado maior do que o 
## o modelo 4 (0.97>0.89) e com isso maior capacidade de explicar a varia��o na vari�vel dependente. 
----------------------------------------------------------------------------------------- 

## Definir diret�rio 

setwd('C:/Users/usuario/Desktop/lista 9 dados')

## Ler arquivo em txt 

load('mammgest.RData')

## Modelo 7 

reg7 <- lm(Gestation ~ Birthwgt, data = mammgest)

summary(reg7)

## Gr�fico de dispers�o modelo 7 

ggplot(data = mammgest, aes(y = Gestation, x = Birthwgt)) + geom_point(color = "blue") + 
theme_classic() + geom_smooth(method = "lm", color = "black", se = FALSE) + 
geom_label(aes(x = 0, y = 500), hjust = 0, 
label = paste("Adj R2 = ",signif(summary(reg7)$adj.r.squared, 5),
" \nP =",signif(summary(reg7)$coef[2,4], 5)))

## O gr�fico sugere que a rela��o entre comprimento de gesta��o e peso ao nascer
## � linear, mas que a vari�ncia dos termos de erro pode n�o ser igual

## Gr�fico dos res�duos versus valores ajustados modelo 7

ggplot(lm(reg7)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0) 

## O gr�fico fornece evid�ncias de que a vari�ncia dos termos dos erros podem n�o 
## ser iguais 

## Gr�fico da normalidade modelo 7 

shap7 <- shapiro.test(reg7$residuals)

ggplot(data = mammgest, aes(sample = reg7$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 50), hjust = 1, 
label = paste ("shapiro.test =",signif(summary(shap7$p.value)[3], 2))) 

## RMSE Modelo 7

rmse(reg7$residuals)

### logar�timo natural do per�odo da gesta��o 

mammgest$lnGest <- log(mammgest$Gestation) 

## Modelo 8 log-linear

reg8 <- lm(log(Gestation) ~ Birthwgt, data = mammgest)

summary(reg8)

## Gr�fico de dispers�o modelo 8 com Y = lnGestation  

ggplot(data = mammgest, aes(y = mammgest$lnGest, x = Birthwgt)) + geom_point(color = "blue") + 
theme_classic() + geom_smooth(method = "lm", color = "black", se = FALSE) + 
geom_label(aes(x = 0, y = 5), hjust = 0, 
label = paste("Adj R2 = ",signif(summary(reg7)$adj.r.squared, 5),
" \nP =",signif(summary(reg7)$coef[2,4], 5)))

## O gr�fico mostra que a tranforma��o na vari�vel Y tendeu a "espalhar" as gesta��es menores e tendeu 
## a "trazer" as maiores. 

## Gr�fico dos res�duos versus valores ajustados modelo 8

ggplot(lm(reg8)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0) 

## O gr�fico mostra uma melhoria acentuada na expans�o dos res�duos

## Gr�fico da normalidade modelo 8 

shap8 <- shapiro.test(reg8$residuals)

ggplot(data = mammgest, aes(sample = reg8$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 0.5), hjust = 1, 
label = paste ("shapiro.test =",signif(summary(shap8$p.value)[3], 2))) 

## RMSE Modelo 8

rmse(reg8$residuals)

## c) 

## Pressupostos 

## No modelo 7 � poss�vel observar que que o gr�fico de dispers�o sugere uma rela��o linear entre o 
## per�odo da gesta��o e o peso ao nascer. Analisando o gr�fico dos res�duos pelos valores ajustados 
## � poss�ver ver evid�ncias de que a vari�ncia dos termos dos erros n�o � igual. O gr�fico da probabilidade 
## do erro mostra evid�ncias dos erros normalmente distribu�do, com o p-valor do teste de Shapiro sendo n�o 
## significativo. Como o  modelo se mostra linear, mas com evid�ncias de ser heteroced�stico, o valor de Y foi 
## transformado em log. Avaliando o modelo 8 � poss�vel observar que no gr�fico de dispers�o, a transforma��o 
## log-level tendeu a melhorar a rela��o linear entre as vari�veis. O gr�fico dos res�duos versus ajustes, 
## mostra uma melhoria acentuada na expans�o dos res�duos e com isso fornecendo evid�ncias de um modelo homoced�stico. 
## Por �ltimo, a transforma��o n�o afetou negativamente a normalidade dos termos dos erros. 

## Resultados do modelo 

## Analisando o ajuste, o modelo 7 apresenta um erro padr�o residual de 66.09, o que indica que a m�dia da amostra se 
## desvia em 66.09 das poss�veis m�dias amostrais. RMSE foi de 59.78. Isso indica que o modelo desvia em m�dia 59.78 pontos ao 
## prever a dura��o da gesta��o.  Os resultados do modelo 8 (transforma��o log-linear), mostram que a varia��o do peso do 
## mam�fero ao nascer em uma unidade implica em 0.01% de varia��o na dura��o da gesta��o, com um p-valor significativo. Comparando 
## os resultados do modelo 7 e 8, em rela��o ao ajuste, o primeiro apresenta um erro padr�o residual maior (66.09), do que 
## o modelo 8 (0.21). Isso significa, que no s�timo modelo, a dist�ncia m�dia entre os pontos do modelo e a reta de regress�o 
## � maior e com isso menos ajustado do que o modelo log-level. O RMSE do modelo 7 tamb�m  � maior do que o modelo 8 (59.78 > 0.19). 
## Isso indica que no oitavo modelo os pontos dos dados observados est�o mais pr�ximos dos valores preditos, do que o s�timo modelo. 
## Em rela��o a capacidade explicativa, o modelo 7 apresenta um R2 ajustado maior do que o modelo 8 (0.82>0.78), o que indica uma 
## maior capacidade de explicar a varia��o na vari�vel dependente.

## 4.2 

## a) 

## Uma regress�o linear requer que a rela��o entre a vari�vel dependente e independente seja linear. 
## Em um modelo polinomial, a distribui��o dos dados � mais complexa. Na linha de regress�o linear � 
## poss�vel capturar os padr�es nos dados. J� em uma regress�o polinomial, n�o h� uma inclina��o �nica 
## que se aplica a toda varia��o de Xi. Com isso, n�o � poss�vel usar o mesmo arcabou�o usado em uma regress�o 
## linear em uma regress�o polinomial. 

## Definir diret�rio 

setwd('C:/Users/usuario/Desktop/lista 9 dados')

## Ler arquivo em txt 

bluegills <- read.delim('bluegills.txt')

reg9 <- lm(length ~ age, data = bluegills)

summary(reg9) 

## Gr�fico de dispers�o modelo 9 

age2 <- bluegills$age^2

ggplot(data = bluegills, aes(y = length, x = age2)) + geom_point(color = "blue") + 
theme_classic()

## Gr�fico dos res�duos por valores ajustados 

ggplot(lm(reg9)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0)

## Gr�fico normalidade modelo 9 

shap9 <- shapiro.test(reg9$residuals)

ggplot(data = bluegills, aes(sample = reg9$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 25), hjust = 1, 
label = paste ("shapiro.test =",signif(summary(shap9$p.value)[3], 2)))

## RMSE modelo 9 

rmse(reg9$residuals)

## Modelo polinomial quadr�tico 

reg10 <- lm(length ~ poly(age, 2, raw = T), data = bluegills)

summary(reg10)

## Gr�fico de dispers�o modelo 10 - comparando a curva linear com a polinomial 

ggplot(data = bluegills) + geom_point(aes(x = age, y = length)) + 
geom_line(aes(x = age, y = reg9$fit), color = 'red') + 
geom_line(aes(x = age, y = reg10$fit), color = 'blue') + 
theme(panel.background = element_blank())

## Gr�fico dos res�duos por valores ajustados 

ggplot(lm(reg10)) + geom_point(aes(x = .fitted, y = .resid)) + geom_abline(slope = 0)

## Gr�fico da normalidade 

shap10 <- shapiro.test(reg10$residuals) 

ggplot(data = bluegills, aes(sample = reg10$residuals)) + 
stat_qq(color = 'blue') + stat_qq_line(color = 'red', lty = 2) + 
geom_label(aes(x = 0, y = 25), hjust = 0, 
label = paste ("shapiro.test =",signif(summary(shap10$p.value)[3], 2)))

## RMSE modelo 10 

rmse(reg10$residuals)

## b) O modelo 9 apresenta um erro padr�o residual de 12.51, o que indica  que a m�dia da amostra se 
## desvia em 12.51 das poss�veis m�dias amostrais. RMSE foi de 12.34. Isso indica que o modelo desvia 
## em m�dia 12.34 pontos ao prever o comprimento em mm dos peixes. O gr�fico de dispers�o do modelo 9, 
## sugere uma tend�ncia positiva nos dados, ou seja, � medida que aumenta a idade do peixe, o comprimento 
## desse tende a aumentar, por�m o gr�fico mostra evid�ncias de uma tend�ncia n�o-linear. O gr�fico dos 
## res�duos versus os valores ajustados, tamb�m sugere um relacionamento n�o-linear entre as vari�veis e 
## mostra evid�ncias de um modelo heteroced�stico, pois existe uma tend�ncia no comportamento dos erros. 
## Analisando QQplot � poss�vel ver que os pontos est�o pr�ximos a linha o que sugere evid�ncias de que 
## a distribui��o dos erros � normal. Com isso, foi adicionado um termo quadr�tico ao modelo. Analisando 
## o modelo 10, em rela��o ao ajuste, o erro padr�o residual foi menor (10.91), do que o modelo 9 (12.51).
## Isso significa, que no nono modelo, a dist�ncia m�dia entre os pontos do modelo e a reta de regress�o 
## � maior e com isso menos ajustado. O RMSE do modelo 9 � maior do que o modelo 10 (12.34 > 10.69). 
## Isso indica que no d�cimo modelo os pontos dos dados observados est�o mais pr�ximos dos valores preditos, 
## do que o  modelo 9. No gr�fico de dispers�o do modelo 10 � poss�vel observar que a regress�o quadr�tica 
## se ajusta melhor aos dados do que o modelo linear. Em rela��o ao pressuposto da normalidade dos res�duos, 
## no gr�fico � poss�vel observar que a distribui��o dos res�duos se aproxima de uma distribui��o normal. 
## No teste de shapiro, o p-valor foi de 0.056, ou seja, n�o significativo (tendo um par�metro de 0.05). 
## Isso indica que os res�duos se aproximam de uma distribui��o normal.  

## c) 

## Criando uma nova coluna com os valores ajustado do modelo 10 

bluegills$fitted.values <- reg10$fitted.values 

## Gr�fico (2) de dispers�o do modelo 10 

ggplot(data = bluegills, aes(y = length, x = age2)) + geom_point(color = "blue") + 
theme_classic() + stat_smooth(method = "lm", formula = y ~ x + I(x^2)) 

## c) O gr�fico de dispers�o do modelo 9 sugere uma tend�ncia positiva dos dados, ou seja, � medida que a 
## idade do peixe aumenta, o comprimento do peixe tende a aumentar. Por�m, chega um momento em que o 
## comprimento decresce quando o peixe chega pr�ximo aos 6 anos, que provavelmente seria a chegada do fim da 
## fase adulta (segundo o wikip�dia o peixe bluegills vive de 5 a 8 anos). A tend�ncia do gr�fico de dispers�o 
## uma rela��o n�o-linear. Como a transforma��o, os resultados da regress�o polinomial do modelo 10 mostram, O 
## B1 associado idade do peixe � de 54.04 e o valor de B2 associado a idade^2 � de -4.71. O termo quadr�tico 
## impacta negativamente a vari�vel dependente de forma crescente a medida que a Vi aumenta. � poss�vel 
## observar essa tend�ncia atrav�s dos valores ajustados. Comparando as primeiras observa��es com as �ltimas 
## (em ordem decrescente), vemos que a medida que o valor de x aumenta (idade) o valor do Y tamb�m aumenta 
## (comprimento). O tamanho do peixe continua aumentando por�m cada vez menos, como sugere o formato c�ncavo 
## do gr�fico 

## Primeiras observa��es 

head(bluegills) ###  Ex: Quando a idade do peixe � 2 o seu comprimento � de 102.84 mm 

## �ltimas observa��es 

tail(bluegills) ###  Ex: Quando a idade do peixe � 5 o seu comprimento � de 165.90 mm 


