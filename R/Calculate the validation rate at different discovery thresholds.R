# Output matrix given different thresholds.
verify <- data.frame(matrix(NA, 9, 9))
names(verify) <- c("p_nspt", "p_cas","nspt_n","cas_n","per_n", "pos","neg","cons","per_cons")
i=1
for(p_nspt in c(1e-7,1e-10,1e-20)){
     
	 for(p_cas in c(5e-2,1e-3,1e-7)){

       # Filter CpG based on a threshold.
       cas_nspt_p <- cas_nspt[cas_nspt$P.NSPT <= p_nspt,]
       nspt_n <- nrow(cas_nspt_p)
       cas_nspt_p <- cas_nspt_p[cas_nspt_p$P.CAS < p_cas,]
       cas_n <- nrow(cas_nspt_p)
       per_n <- cas_n/nspt_n
       # Filter CpG based on the direction of effect.
       pos <- sum(cas_nspt_p$BETA.NSPT > 0 & cas_nspt_p$BETA.CAS  >0)
       neg <- sum(cas_nspt_p$BETA.NSPT < 0 & cas_nspt_p$BETA.CAS  <0)
       cons <- (pos+neg)
       per_cons <- (pos+neg) / nrow(cas_nspt_p)
       verify[i,] <- c(p_nspt, p_cas,nspt_n,cas_n,per_n, pos,neg,cons,per_cons)
       i = i+1
     }

}
