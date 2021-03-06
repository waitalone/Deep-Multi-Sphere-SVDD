#!/usr/bin/env bash

device=$1
xp_dir=log/$2
seed=$3
solver=$4
lr=$5
n_epochs=$6
pretrain=$7
mnist_normal=$8
mnist_outlier=$9
n_cluster=${10}
nu=${11}
mnist_rep_dim=${12}
info_file=${13}

mkdir $xp_dir;

# MNIST training
python baseline.py --dataset mnist --solver $solver --loss msvdd --lr $lr --lr_drop 1 --lr_drop_in_epoch 50 \
    --seed $seed --lr_drop_factor 10 --block_coordinate 0 --R_update_solver minimize_scalar \
    --R_update_scalar_method bounded --R_update_lp_obj primal --use_batch_norm 1 --pretrain $pretrain \
    --batch_size 200 --n_epochs $n_epochs --device $device --xp_dir $xp_dir --leaky_relu 1 --weight_decay 1 --C 1e6 \
    --hard_margin 1 --nu 0.1 --weight_dict_init 1 --unit_norm_used l1 --gcn 1 --mnist_rep_dim $mnist_rep_dim \
    --mnist_normal $mnist_normal --mnist_outlier $mnist_outlier --n_cluster $n_cluster --plot_examples 1 --mnist_bias 0 \
    --nu $nu --info_file $info_file --out_frac 0;
