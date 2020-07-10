#/usr/local/bin/R
#DianaOaxaca

#1. Read table
EnzAct <- read.csv("Enzymatic_activity.csv")
#2. See content of variable
EnzAct
#3. Get stats
descript_stat <- EnzAct %>% group_by(Strain) %>% summarise(n= n(), media = mean(Enzymatic.Activity, na.rm =  TRUE), mediana = median(Enzymatic.Activity, na.rm =  TRUE), varianza = var(Enzymatic.Activity, na.rm =  TRUE))
descript_stat
#RESULTS:
# A tibble: 3 x 5
#Strain      n media mediana varianza
#<chr>   <int> <dbl>   <dbl>    <dbl>
#  1 WCP3a       4 0.522  0.530  0.0164  
#2 WcSnc40     4 0.150  0.17   0.00205 
#3 WcSnc45     4 0.092  0.0865 0.000553 
###So, when the variance are not equal, don't compare yours means

#4. Normality test

shapiro.test(EnzAct$Enzymatic.Activity)
#RESULTS
	#Shapiro-Wilk normality test
        #data:  EnzAct$Enzymatic.Activity..U.mL.
        #W = 0.80718, p-value = 0.01132  #Don't normal, so No parametric test

#5. Kruskal-Wallis
kruskal.test(Enzymatic.Activity ~ Strain, data= EnzAct)
#RESULTS:
	#Kruskal-Wallis rank sum test
        #data:  Enzymatic.Activity..U.mL. by Strain
        #Kruskal-Wallis chi-squared = 8.3462, df = 2, p-value = 0.0154
        #KW test was significative, so is good idea run post-hoc test for 
        #compare significative samples with Tukey and Kramer (Nemenyi) test or Dunn test

#ggboxplot(EnzAct, x = "Strain", y = "Enzymatic.Activity", color = "Strain", palette = "jco") +
#  stat_compare_means(method = "kruskal.test")
##OR
#6. Complete analysis and plot with ggpubr
my_comparisons <- list(c("WcSnc40", "WcSnc45"), c("WcSnc45","WCP3a"), c("WcSnc40", "WCP3a"))
ggboxplot(EnzAct, x = "Strain", y = "Enzymatic.Activity", color = "Strain", palette = "lancet") +
  stat_compare_means(comparisons = my_comparisons) + theme() +  stat_compare_means(label.y = 1)

##OD evolution the same analysis flow as above

OD <- read.csv("OD24.csv")
OD
ODstat <- OD %>% group_by(Strain) %>% summarise(n= n(), media = mean(OD_24h, na.rm =  TRUE), mediana = median(OD_24h, na.rm =  TRUE), varianza = var(OD_24h, na.rm =  TRUE))
ODstat
shapiro.test(OD$OD_24h)
kruskal.test(OD_24h ~ Strain, data= OD)
my_comparisonsOD2 <- list(c("WcSnc40","WcL17"), c("WcL17","WcL9"))
ggboxplot(OD, x = "Strain", y = "OD_24h", color = "Strain", palette = "lancet") +
    stat_compare_means(comparisons = my_comparisonsOD2)  + stat_compare_means(label.y = 1)
