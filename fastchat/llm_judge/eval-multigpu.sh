#!/bin/bash
#SBATCH --job-name=eval
#SBATCH -p palamut-cuda                      # Kuyruk adi: Uzerinde GPU olan kuyruk olmasina dikkat edin.
#SBATCH -A proj12                            # Kullanici adi
#SBATCH -o %J-Qwen2-72B-Instruct-4gpu.out           # Ciktinin yazilacagi dosya adi
#SBATCH --gres=gpu:4                         # Her bir sunucuda kac GPU istiyorsunuz? Kumeleri kontrol edin.
#SBATCH -N 1                                 # Gorev kac node'da calisacak?
#SBATCH -n 1                                 # Ayni gorevden kac adet calistirilacak?
#SBATCH --cpus-per-task 64                   # Her bir gorev kac cekirdek kullanacak? Kumeleri kontrol edin.
#SBATCH --time=3-0:0:0                       # Sure siniri koyun.


echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo

eval "$(/truba/home/$USER/miniconda3/bin/conda shell.bash hook)"
source activate FastChat
echo 'number of processors:'$(nproc)
nvidia-smi

python gen_model_answer.py --model-path Qwen/Qwen2-72B-Instruct --model-id Qwen2-72B-Instruct --num-gpus-per-model 4 --num-gpus-total 4