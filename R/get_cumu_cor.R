# compute the cumulative score and correlation
get_cumu_rep_cor <- function(cpg, nspt_cpg, nspt_beta, age_data, step , rep ) {
                      # set number
                      sample_num <- c(seq(0,length(nspt_cpg),step),length(nspt_cpg))
                      # prepare data.frame
                      cor <- data.frame(matrix(NA, rep, length(sample_num)))
                      colnames(cor) <- paste0("CpG",sample_num)
                      for(i in 1:length(sample_num)) {
                               # step begin 0
                               if(i==1 & sample_num[i]==0) {
                                    cor[,i] <- 0
                                    }
                               else if (i>1 & sample_num[i]>1){ #step wise
                                    # prepare cor 
                                    cor_rep <- c(NA)
                                    for(j in 1:rep){
                                                # random cpgs
                                                cpg_index <- sample(1:length(nspt_cpg), sample_num[i])
                                                # get scores
                                                score_cpg <- nspt_cpg[cpg_index]
                                                cpg_score <- data.frame(apply(cpg[,score_cpg], 2, function(x) {abs(x - mean(x)) / sd(x)}))
                                                cpg_score_age <- apply(cpg_score,1,function(x){ sum(x * nspt_beta[cpg_index])})
                                                cor_rep[j] <- cor(cpg_score_age, age_data)
                                                }
                                    cor[,i] <- cor_rep
                                  }
                            }
                       return(cor)
}
