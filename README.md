## The AWX turnkey installer 

###Tips
sudo iptables -A POSTROUTING -o wlp3s0 -j MASQUERADE -t nat

kubectl exec --stdin --tty awx-miracle-bfc979bcb-g8fpv -c awx-miracle-web --  bash
