##########################################################################
##########################################################################
# W這c豉wek

######################################################################
######################################################################
library(RColorBrewer)
palette(brewer.pal(n = 8, name = "Set1"))
CWW = c(232.2, 205.3, 198.1, 145.3, 121.9, 99.2, 69.5, 37.9)
results_df = data.frame(iteration=1:50)
for (a in 1:8)
{
  file_name = paste("results/Wloclawek/23-11-2024 18-57-07/MSE_optimization_", (a-1), ".csv", sep='')
  df = read.csv(file_name) 
  results_df[,a+1] = df$error
}
y_max = max(results_df[,2:9]) + 0.01
#par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
plot(x=results_df$iter, y=results_df[,2], ylim = c(0,y_max), 
     xlab = 'Iteration', ylab = 'F_MSE', col=1, main="Optimization of F_MSE, W這c豉wek")
lines(x=results_df$iter, y=results_df[,2], col=1)
for (a in 3:9)
{
  points(x=results_df$iter, y=results_df[,a], col=a-1)
  lines(x=results_df$iter, y=results_df[,a], col=a-1)
}
grid(NULL, NULL)
legend("topright", inset=c(0.05,0.1), legend = 1:8, col = 1:8, pch = 1, cex=0.85, title="Id")

###########################################################

library(RColorBrewer)
palette(brewer.pal(n = 8, name = "Set1"))
results_df = data.frame(iteration=1:50)
for (a in 1:8)
{
  file_name = paste("results/Wloclawek/23-11-2024 19-47-37/jensenshannon_optimization_", (a-1), ".csv", sep='')
  df = read.csv(file_name) 
  results_df[,a+1] = df$error
}
y_max = max(results_df[,2:9]) + 0.01

#par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
plot(x=results_df$iter, y=results_df[,2], ylim = c(0,y_max), 
     xlab = 'Iteration', ylab = 'F_JSD', col=1, main="Optimization of F_JSD, W這c豉wek")
lines(x=results_df$iter, y=results_df[,2], col=1)
for (a in 3:9)
{
  points(x=results_df$iter, y=results_df[,a], col=a-1)
  lines(x=results_df$iter, y=results_df[,a], col=a-1)
}
grid(NULL, NULL)
legend("topright", inset=c(0.05,0.1), legend = 1:8, col = 1:8, pch = 1, cex=0.85, title="Id")

##################################################################################################
##########################################################################
##########################################################################
# Dobczyce 

######################################################################
######################################################################
library(RColorBrewer)
palette(brewer.pal(n = 8, name = "Set1"))
CWW = c(253, 208, 153, 102, 102, 51, 51)
results_df = data.frame(iteration=1:50)
for (a in 1:7)
{
  file_name = paste("results/Dobczyce/15-11-2024 23-41-27/MSE_optimization_", a - 1, ".csv", sep='')
  df = read.csv(file_name) 
  results_df[,a+1] = df$error
}
y_max = max(results_df[,2:8]) + 0.01

plot(x=results_df$iter, y=results_df[,2], ylim = c(0,y_max), 
     xlab = 'Iteration', ylab = 'F_MSE', col=1, main="Optimization of F_MSE, Dobczyce")
lines(x=results_df$iter, y=results_df[,2], col=1)
for (a in 3:8)
{
  points(x=results_df$iter, y=results_df[,a], col=a-1)
  lines(x=results_df$iter, y=results_df[,a], col=a-1)
}
grid(NULL, NULL)
legend("topright", inset=c(0.05,0.1), legend = 1:7, col = 1:7, pch = 1, cex=0.85, title="Id")

###########################################################

library(RColorBrewer)
palette(brewer.pal(n = 8, name = "Set1"))
results_df = data.frame(iteration=1:50)
for (a in 1:7)
{
  file_name = paste("results/Dobczyce/16-11-2024 00-29-04/jensenshannon_optimization_", a - 1, ".csv", sep='')
  df = read.csv(file_name) 
  results_df[,a+1] = df$error
}
y_max = max(results_df[,2:8]) + 0.01

plot(x=results_df$iter, y=results_df[,2], ylim = c(0,y_max), 
     xlab = 'Iteration', ylab = 'F_MSE', col=1, main="Optimization of F_JSD, Dobczyce")
lines(x=results_df$iter, y=results_df[,2], col=1)
for (a in 3:8)
{
  points(x=results_df$iter, y=results_df[,a], col=a-1)
  lines(x=results_df$iter, y=results_df[,a], col=a-1)
}
grid(NULL, NULL)
legend("topright", inset=c(0.05,0.1), legend = 1:7, col = 1:7, pch = 1, cex=0.85, title="Id")

##################################################################################################
# Density plots
# W這c豉wek 
library(RColorBrewer)
palette(brewer.pal(n = 8, name = "Set1"))

# W這c豉ek
df = read.csv('results\\Wloclawek\\23-11-2024 18-57-07\\MSE_results.csv')
df$exp.mu. = log(df$exp.mu.)


# Add a density curve
plot(0,0,xlim=c(0,1000),ylim=c(0,0.04), xlab = "t [h]", ylab = "Density", main = "Density of t [h], F_MSE, W這clawek")
id = 1
curve(dlnorm(x, meanlog=(df$exp.mu.[id]), sdlog=df$s[id]), from=0, to=1000, col=1, add = TRUE)



my_legend = sprintf("%d, %0.2f, %0.2f",1, df$exp.mu.[id],df$s[id])
for (id in 2:8)
{
  curve(dlnorm(x, meanlog=(df$exp.mu.[id]), sdlog=df$s[id]), from=0, to=1000, add = TRUE, col=id)
  my_legend = c(my_legend, sprintf("%d, %0.2f, %0.2f",id, df$exp.mu.[id],df$s[id]))
}
grid(NULL, NULL)
legend("topright", inset=c(0.05,0.1), legend = my_legend, col = 1:8, pch = 1, cex=0.85, title="id, mu, sigma")

##################################

library(RColorBrewer)
palette(brewer.pal(n = 8, name = "Set1"))
# W這c豉wek
df = read.csv('results\\Wloclawek\\23-11-2024 19-47-37\\jensenshannon_results.csv')
df$exp.mu. = log(df$exp.mu.)

# Add a density curve
plot(0,0,xlim=c(0,1000),ylim=c(0,0.04), xlab = "t [h]", ylab = "Density", main = "Density of t [h], F_JSD, W這clawek")
id = 1
curve(dlnorm(x, meanlog=(df$exp.mu.[id]), sdlog=df$s[id]), from=0, to=1000, col=1, add = TRUE)



my_legend = sprintf("%d, %0.2f, %0.2f",1, df$exp.mu.[id],df$s[id])
for (id in 2:8)
{
  curve(dlnorm(x, meanlog=(df$exp.mu.[id]), sdlog=df$s[id]), from=0, to=1000, add = TRUE, col=id)
  my_legend = c(my_legend, sprintf("%d, %0.2f, %0.2f",id, df$exp.mu.[id],df$s[id]))
}
grid(NULL, NULL)
legend("topright", inset=c(0.05,0.1), legend = my_legend, col = 1:8, pch = 1, cex=0.85, title="id, mu, sigma")

####################################################
# Dobczyce
library(RColorBrewer)
palette(brewer.pal(n = 8, name = "Set1"))

df = read.csv('results\\Dobczyce\\15-11-2024 23-41-27\\MSE_results.csv')
df$exp.mu. = log(df$exp.mu.)

# Add a density curve
plot(0,0,xlim=c(0,1000),ylim=c(0,0.005), xlab = "t [h]", ylab = "Density", main = "Density of t [h], F_MSE, Dobczyce")
id = 1
curve(dlnorm(x, meanlog=(df$exp.mu.[id]), sdlog=df$s[id]), from=0, to=1000, col=1, add = TRUE)

my_legend = sprintf("%d, %0.2f, %0.2f",1, df$exp.mu.[id],df$s[id])
for (id in 2:7)
{
  curve(dlnorm(x, meanlog=(df$exp.mu.[id]), sdlog=df$s[id]), from=0, to=1000, add = TRUE, col=id)
  my_legend = c(my_legend, sprintf("%d, %0.2f, %0.2f",id, df$exp.mu.[id],df$s[id]))
}
grid(NULL, NULL)
legend("topright", inset=c(0.05,0.1), legend = my_legend, col = 1:7, pch = 1, cex=0.85, title="id, mu, sigma")

####################################################

library(RColorBrewer)
palette(brewer.pal(n = 8, name = "Set1"))
df = read.csv('results\\Dobczyce\\16-11-2024 00-29-04\\jensenshannon_results.csv')
df$exp.mu. = log(df$exp.mu.)

# Add a density curve
plot(0,0,xlim=c(0,1000),ylim=c(0,0.005), xlab = "t [h]", ylab = "Density", main = "Density of t [h], F_JSD, Dobczyce")
id = 1
curve(dlnorm(x, meanlog=(df$exp.mu.[id]), sdlog=df$s[id]), from=0, to=1000, col=1, add = TRUE)

my_legend = sprintf("%d, %0.2f, %0.2f",1, df$exp.mu.[id],df$s[id])
for (id in 2:7)
{
  curve(dlnorm(x, meanlog=(df$exp.mu.[id]), sdlog=df$s[id]), from=0, to=1000, add = TRUE, col=id)
  my_legend = c(my_legend, sprintf("%d, %0.2f, %0.2f",id, df$exp.mu.[id],df$s[id]))
}
grid(NULL, NULL)
legend("topright", inset=c(0.05,0.1), legend = my_legend, col = 1:7, pch = 1, cex=0.85, title="id, mu, sigma")


#########################################################
# Data tables
# W這c豉wek
df1 = read.csv('results\\Wloclawek\\23-11-2024 18-57-07\\MSE_results.csv')
df1$exp.mu. = log(df1$exp.mu.)
df2 = read.csv('results\\Wloclawek\\23-11-2024 19-47-37\\jensenshannon_results.csv')
df2$exp.mu. = log(df2$exp.mu.)


sink(file = "tables/wloclawek.txt")
id = 1
for (a in 1:nrow(df1))
{
  my_str = sprintf("%d & %0.3f & %0.3f & %0.3f & %0.3f & %0.3f & %0.3f \\\\ \n",id, df1$exp.mu.[id],df1$s[id],df1$error[id], df2$exp.mu.[id],df2$s[id],df2$error[id])
  cat(my_str)
  id = id + 1
}
sink(file = NULL)


#########################################################
# Data tables
# Dobczyce
df1 = read.csv('results\\Dobczyce\\15-11-2024 23-41-27\\MSE_results.csv')
df1$exp.mu. = log(df1$exp.mu.)
df2 = read.csv('results\\Dobczyce\\16-11-2024 00-29-04\\jensenshannon_results.csv')
df2$exp.mu. = log(df2$exp.mu.)


sink(file = "tables/Dobczyce.txt")
id = 1
for (a in 1:nrow(df1))
{
  my_str = sprintf("%d & %0.3f & %0.3f & %0.3f & %0.3f & %0.3f & %0.3f \\\\ \n",id, df1$exp.mu.[id],df1$s[id],df1$error[id], df2$exp.mu.[id],df2$s[id],df2$error[id])
  cat(my_str)
  id = id + 1
}
sink(file = NULL)

#########################################################

# W這c豉wek
df_wloclawek_mse = read.csv('results\\Wloclawek\\23-11-2024 18-57-07\\MSE_results.csv')
df_wloclawek_mse$exp.mu. = log(df_wloclawek_mse$exp.mu.)

df_wloclawek_jsd = read.csv('results\\Wloclawek\\23-11-2024 19-47-37\\jensenshannon_results.csv')
df_wloclawek_jsd$exp.mu. = log(df_wloclawek_jsd$exp.mu.)

CWW_wloclawek = c(232.2, 205.3, 198.1, 145.3, 121.9, 99.2, 69.5, 37.9)

df_wloclawek_mse$mean = exp(df_wloclawek_mse$exp.mu. + (df_wloclawek_mse$s ^ 2)/2)
df_wloclawek_jsd$mean = exp(df_wloclawek_jsd$exp.mu. + (df_wloclawek_jsd$s ^ 2)/2)


# Dobczyce
df_dobczyce_mse = read.csv('results\\Dobczyce\\15-11-2024 23-41-27\\MSE_results.csv')
df_dobczyce_mse$exp.mu. = log(df_dobczyce_mse$exp.mu.)
df_dobczyce_jsd = read.csv('results\\Dobczyce\\16-11-2024 00-29-04\\jensenshannon_results.csv')
df_dobczyce_jsd$exp.mu. = log(df_dobczyce_jsd$exp.mu.)

CWW_dobczyce = c(253, 208, 153, 102, 102, 51, 51)

df_dobczyce_mse$mean = exp(df_dobczyce_mse$exp.mu. + (df_dobczyce_mse$s ^ 2)/2)
df_dobczyce_jsd$mean = exp(df_dobczyce_jsd$exp.mu. + (df_dobczyce_jsd$s ^ 2)/2)



###############
# PLOT MSE

X = CWW_wloclawek
Y = df_wloclawek_mse$mean[1:8]
sum_lm = summary(lm(Y~X,data.frame(X,Y)))
#Get coefficients
coef_lm<-sum_lm$coefficients

plot(X, Y, xlab = 'WET [h]', ylab = 'Et [h]', col='red', main='Et as function of WET, F_MSE estimation',ylim=c(0,1000), xlim=c(0,300))
abline(a = coef_lm[1,1], 
       b = coef_lm[2,1], 
       col = "red",
       lwd = 2)
grid(NULL, NULL)
text(x = 150, 
     y = 200,
     col = 'red',
     labels = paste0("W這c豉wek\n",
                     "y = ", 
                     #Round slope coefficient to 2 decimals
                     round(coef_lm[2,1],2),
                     "x ", 
                     #Round intercept coefficient to 2 decimals
                     round(coef_lm[1,1],2),
                     "\nR^2 = ",
                     #Round r.squared to 2 decimals
                     round(sum_lm$r.squared,2)),
     pos = 3)




X = CWW_dobczyce
Y = df_dobczyce_mse$mean[1:7]
sum_lm = summary(lm(Y~X,data.frame(X,Y)))
#Get coefficients
coef_lm<-sum_lm$coefficients

points(X, Y, xlab = 'WET [h]', ylab = 'Et [h]', col='blue')
abline(a = coef_lm[1,1], 
       b = coef_lm[2,1], 
       col = "blue",
       lwd = 2)

text(x = 100, 
     y = 700,
     col = 'blue',
     labels = paste0("Dobczyce\n",
                    "y = ", 
                     #Round slope coefficient to 2 decimals
                     round(coef_lm[2,1],2),
                     "x + ", 
                     #Round intercept coefficient to 2 decimals
                     round(coef_lm[1,1],2),
                     "\nR^2 = ",
                     #Round r.squared to 2 decimals
                     round(sum_lm$r.squared,2)),
     pos = 3)


###############
# PLOT JSD

X = CWW_wloclawek
Y = df_wloclawek_jsd$mean[1:8]
sum_lm = summary(lm(Y~X,data.frame(X,Y)))
#Get coefficients
coef_lm<-sum_lm$coefficients

plot(X, Y, xlab = 'WET [h]', ylab = 'Et [h]', col='red', main='Et as function of WET, F_JSD estimation',ylim=c(0,1000), xlim=c(0,300))
abline(a = coef_lm[1,1], 
       b = coef_lm[2,1], 
       col = "red",
       lwd = 2)
grid(NULL, NULL)
text(x = 150, 
     y = 200,
     col = 'red',
     labels = paste0("W這c豉wek\n",
                     "y = ", 
                     #Round slope coefficient to 2 decimals
                     round(coef_lm[2,1],2),
                     "x ", 
                     #Round intercept coefficient to 2 decimals
                     round(coef_lm[1,1],2),
                     "\nR^2 = ",
                     #Round r.squared to 2 decimals
                     round(sum_lm$r.squared,2)),
     pos = 3)




X = CWW_dobczyce
Y = df_dobczyce_jsd$mean[1:7]
sum_lm = summary(lm(Y~X,data.frame(X,Y)))
#Get coefficients
coef_lm<-sum_lm$coefficients

points(X, Y, xlab = 'WET [h]', ylab = 'Et [h]', col='blue')
abline(a = coef_lm[1,1], 
       b = coef_lm[2,1], 
       col = "blue",
       lwd = 2)

text(x = 100, 
     y = 700,
     col = 'blue',
     labels = paste0("Dobczyce\n",
                     "y = ", 
                     #Round slope coefficient to 2 decimals
                     round(coef_lm[2,1],2),
                     "x + ", 
                     #Round intercept coefficient to 2 decimals
                     round(coef_lm[1,1],2),
                     "\nR^2 = ",
                     #Round r.squared to 2 decimals
                     round(sum_lm$r.squared,2)),
     pos = 3)
