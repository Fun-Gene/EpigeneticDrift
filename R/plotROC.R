plotROC <- function(.data, predict_col, target, group, positive=1){

  predict_col <- enquo(predict_col)
  target <- enquo(target)
  group  <- enquo(group)

  predictN <- quo_name(predict_col)
  groupN   <- quo_name(group)

  df <- .data %>% dplyr::select(!! predict_col, !! target, !! group) %>%
    mutate(targetN = ifelse(!! target == positive, 1, 0)) %>% as.data.frame()

  p  <- df %>%  ggplot(aes_string(m = predictN,
                                  d = "targetN",
                                  color = groupN)) + geom_roc(n.cuts = 0, show.legend = TRUE, labels=FALSE)

  ng <- levels(factor(df[, groupN]))
  auc <- calc_auc(p)$AUC
  names(auc) <- ng
  auc <- base::sort(auc, decreasing = TRUE)
  p <- p +
    annotate("text", x = .7, y = .3,
             label = paste(names(auc)[1], ":\nAUC =", round(auc[1], 3), "\n\n",
                           names(auc)[2], ":\nAUC =", round(auc[2], 3), "\n"),
             size = 4) +
    theme_bw() +
    theme(axis.line.x.top = element_line(),
          axis.line.x.bottom = element_line(),
          axis.line.y.left = element_line(),
          axis.line.y.right = element_line(),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          plot.title = element_text(hjust = 0.5)) +
    labs(title = paste('Bias =', 5))

  p + xlab("FPR") + ylab("TPR") +
    scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
}

