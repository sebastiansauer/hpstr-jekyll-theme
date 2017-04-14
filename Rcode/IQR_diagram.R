### intuition on the median

library(dplyr)
library(tidyr)
library(ggplot2)


Gehalt <- data.frame(
  Equalizia  = c(37, 38, 40, 41, 43, 44.5, 45, 47, 51, 61),
  Extremistan = c(13, 17, 21, 41, 45, 31, 68, 72, 74, 76)
)

median(Gehalt$Equalizia)
median(Gehalt$Extremistan)



Gehalt_long <- gather(Gehalt, key = Land, value = Gehalt)
Gehalt_long_count <- count(Gehalt_long, Land, Gehalt)


Gehalt_long %>%
  group_by(Land) %>%
  summarise(q1 = quantile(Gehalt, probs = .25),
            q3 = quantile(Gehalt, probs = .75),
            q2 = quantile(Gehalt, probs = .5)) -> Gehalt_quartile


IQR_plot <-
ggplot(Gehalt_long_count) +
  aes(y = Gehalt, x = n) +
  facet_wrap(~Land, ncol = 1) +
  geom_point() +
  geom_hline(data = Gehalt_quartile, aes(yintercept = q1), color = "#00998a", linetype = "dashed") +
  geom_hline(data = Gehalt_quartile, aes(yintercept = q3), color = "#00998a", linetype = "dashed") +
  scale_x_continuous(name = "", breaks = 0:2, limits = c(0,2)) +
  geom_segment(data = Gehalt_quartile, aes(y = q1, yend = q3, x = 1.1, xend = 1.1), color = "#8F1A15", size = 2) +
  geom_text(data = Gehalt_quartile, aes(label = paste("IQR = ", q3-q1), y = q2), x = 2, hjust = 1) +
  theme(strip.text = element_text(size=20))

IQR_plot

