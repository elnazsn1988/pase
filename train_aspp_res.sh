#!/bin/bash
#SBATCH -J aspp
#SBATCH -o log/aspp_32000
#SBATCH --mem=32GB
#SBATCH -t 5-00:00:00
#SBATCH -n 1
#SBATCH -c 8
#SBATCH -p gpu
#SBATCH --gres=gpu -C K80

nvidia-smi

python -u  train.py --batch_size 8 --epoch 50 --save_path /export/team-mic/zhong/test/aspp_res2d_rev_noise \
       --num_workers 3 --warmup 10000000 --net_cfg cfg/workers_aspp.cfg \
       --fe_cfg cfg/PASE_aspp_res.cfg --do_eval --data_cfg /export/corpora/LibriSpeech_50h/librispeech_data_50h.cfg \
       --min_lr 0.0005 --fe_lr 0.0005 --data_root /export/corpora/LibriSpeech_50h/wav_sel \
       --dtrans_cfg cfg/distortions/all.cfg \
       --stats data/librispeech_50h_stats.pkl \
       --chunk_size 32000 \
       --random_scale True \
       --backprop_mode base\
       --lr_mode poly \
       --tensorboard True \
       --sup_exec ./sup_cmd.txt --sup_freq 10 --log_freq 1

