library(ggplot2)
library(ggthemes)
library(tidyverse)

spread_data = read_csv("spread.csv")
repeat_data = read_csv("repeat.csv")
linear_data = read_csv("linear.csv")
work_data = read_csv("work.csv")

ggplot() + 
    geom_point(data = spread_data[spread_data$work == 1,], aes(x=log_spread, y=time_ns, color="spread")) +
    xlab("log₂(spread)") +
    ylab("time (ns)") +
    scale_colour_manual(name="legend", values=c("spread" = "blue")) +
    theme_bw()


ggplot() + 
  geom_point(data = spread_data[spread_data$work == 1 & spread_data$log_spread <= 20,], aes(x=log_spread, y=time_ns, color="spread")) +
  xlab("log₂(spread)") +
  ylab("time (ns)") +
  scale_colour_manual(name="legend", values=c("spread" = "blue")) +
  theme_bw()
  

ggplot() + 
  geom_point(data = repeat_data[repeat_data$work == 1,], aes(x=log_spread, y=time_ns, color="repeat")) +
  xlab("log₂(spread)") +
  ylab("time (ns)") +
  scale_colour_manual(name="legend", values=c("repeat" = "orange")) +
  theme_bw()


ggplot() + 
  geom_point(data = repeat_data[repeat_data$work == 1 & repeat_data$log_spread <= 17,], aes(x=log_spread, y=time_ns, color="repeat")) +
  xlab("log₂(spread)") +
  ylab("time (ns)") +
  scale_colour_manual(name="legend", values=c("repeat" = "orange")) +
  theme_bw()

ggplot() + 
  geom_point(data = repeat_data[repeat_data$work == 32,], aes(x=log_spread, y=time_ns, color="repeat (32)")) +
  xlab("log₂(spread)") +
  ylab("time (ns)") +
  scale_colour_manual(name="legend", values=c("repeat (32)" = "orange4")) +
  theme_bw()

ggplot() + 
  geom_point(data = repeat_data[repeat_data$work == 1,], aes(x=log_spread, y=throughput_melem_s, color="repeat")) +
  geom_point(data = repeat_data[repeat_data$work == 32,], aes(x=log_spread, y=throughput_melem_s, color="repeat (32)")) +
  xlab("log₂(spread)") +
  ylab("throughput (MElem/s)") +
  scale_colour_manual(name="legend", values=c("repeat" = "orange", "repeat (32)" = "orange4")) +
  theme_bw()

ggplot() + 
  geom_point(data = spread_data[spread_data$work == 1,], aes(x=log_spread, y=time_ns, color="spread")) +
  geom_point(data = repeat_data[repeat_data$work == 1,], aes(x=log_spread, y=time_ns, color="repeat")) +
  xlab("log₂(spread)") +
  ylab("time (ns)") +
  scale_colour_manual(name="legend", values=c("spread" = "blue", "repeat" = "orange")) +
  theme_bw()

ggplot() + 
  geom_point(data = spread_data[spread_data$work == 1,], aes(x=log_spread, y=throughput_melem_s, color="spread")) +
  geom_point(data = repeat_data[repeat_data$work == 1,], aes(x=log_spread, y=throughput_melem_s, color="repeat")) +
  xlab("log₂(spread)") +
  ylab("throughput (MElem/s)") +
  scale_colour_manual(name="legend", values=c("spread" = "blue", "repeat" = "orange")) +
  theme_bw()

ggplot() + 
  geom_point(data = spread_data[spread_data$work == 32,], aes(x=log_spread, y=time_ns, color="spread (32)")) +
  geom_point(data = repeat_data[repeat_data$work == 32,], aes(x=log_spread, y=time_ns, color="repeat (32)")) +
  xlab("log₂(spread)") +
  ylab("time (ns)") +
  scale_colour_manual(name="legend", values=c("spread (32)" = "blue4", "repeat (32)" = "orange4")) +
  theme_bw()

ggplot() + 
  geom_point(data = spread_data[spread_data$work == 1,], aes(x=log_spread, y=throughput_melem_s, color="spread")) +
  geom_point(data = repeat_data[repeat_data$work == 1,], aes(x=log_spread, y=throughput_melem_s, color="repeat")) +
  geom_point(data = spread_data[spread_data$work == 32,], aes(x=log_spread, y=throughput_melem_s, color="spread (32)")) +
  geom_point(data = repeat_data[repeat_data$work == 32,], aes(x=log_spread, y=throughput_melem_s, color="repeat (32)")) +
  xlab("log₂(spread)") +
  ylab("throughput (MElem/s)") +
  scale_colour_manual(name="legend", values=c(
    "spread" = "blue", "repeat" = "orange",
    "spread (32)" = "blue4", "repeat (32)" = "orange4"
    )) +
  theme_bw()

ggplot() + 
  geom_point(data = spread_data[spread_data$work == 1,], aes(x=log_spread, y=throughput_melem_s, color="spread")) +
  geom_point(data = repeat_data[repeat_data$work == 1,], aes(x=log_spread, y=throughput_melem_s, color="repeat")) +
  geom_point(data = spread_data[spread_data$work == 32,], aes(x=log_spread, y=throughput_melem_s, color="spread (32)")) +
  geom_point(data = repeat_data[repeat_data$work == 32,], aes(x=log_spread, y=throughput_melem_s, color="repeat (32)")) +
  geom_point(data = linear_data, aes(x=log_spread, y=throughput_melem_s, color="linear")) +
  xlab("log₂(spread)") +
  ylab("throughput (MElem/s)") +
  scale_colour_manual(name="legend", values=c(
    "spread" = "blue", "repeat" = "orange",
    "spread (32)" = "blue4", "repeat (32)" = "orange4",
    "linear" = "purple"
  )) +
  theme_bw()

ggplot() + 
  geom_point(data = linear_data, aes(x=log_spread, y=throughput_melem_s, color="linear")) +
  xlab("log₂(spread)") +
  ylab("throughput (MElem/s)") +
  scale_colour_manual(name="legend", values=c(
    "spread" = "blue", "repeat" = "orange",
    "spread (32)" = "blue4", "repeat (32)" = "orange4",
    "linear" = "purple"
  )) +
  theme_bw()

ggplot() + 
  geom_point(data = linear_data, aes(x=log_spread, y=time_ns, color="linear")) +
  xlab("log₂(spread)") +
  ylab("time (ns)") +
  scale_colour_manual(name="legend", values=c("linear" = "purple")) +
  theme_bw()