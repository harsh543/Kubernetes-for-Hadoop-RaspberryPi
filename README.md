# Purpose #

Create a private cloud using Raspberry PIs (ARM architecture) and use Kubernetes 
for container orchastration to run MapReduce jobs using Apache Hadoop.  

### What is this repository for? ###

* A how-to guide for construction of cluster.
* Provide the resources required for the construction of the cluster. 

### Hardware required ###

* Raspberry PIs [[Buy](https://www.amazon.com/Raspberry-Pi-RASPBERRYPI3-MODB-1GB-Model-Motherboard/dp/B01CD5VC92)]
* Power suppy [[Buy](https://www.amazon.com/CanaKit-Raspberry-Supply-Adapter-Charger/dp/B00MARDJZ4/ref=pd_bxgy_147_2?_encoding=UTF8&psc=1&refRID=6M8CYG5AKF2YM9H09JBN)]
* SD card [[Buy](https://www.amazon.com/Samsung-MicroSD-Adapter-MB-ME32GA-AM/dp/B06XWN9Q99/ref=pd_bxgy_147_3?_encoding=UTF8&psc=1&refRID=6M8CYG5AKF2YM9H09JBN)]

### Assumptions ###

* We have 8 Raspberry PIs (1 Master, 7 Slaves).

### Repositories and images created and utilized ###

* Docker image using base as amr7 ubuntu with hadoop and java on top [Link to image: [amr7-ubuntu-hd](https://hub.docker.com/r/raghavendrasomannavar/amr7-ubuntu-hd/)]
* Shell scripts to automate the process of kubernetes cluster setup[Link to repo: [Kube-Construct](https://github.com/dark-shade/kube-construct)] 

### How do I get set up? ###

##### Without Kube-Construct #####

1. Power On the PIs.
2. Install an OS on all PIs [we will be using Hypriot] [[Link](https://github.com/hypriot/image-builder-rpi/releases)].
3. Install Kubernetes on PIs [Use this blog: [Hypriot blog](https://blog.hypriot.com/post/setup-kubernetes-raspberry-pi-cluster/)] .
4. Setup Master [As mentioned in the Hypriot Blog].
5. Connect the slaves [As mentioned in the Hypriot Blog].
6. Setup Flannel [As mentioned in the Hypriot Blog].
7. Start the service by executing `kubectl run hw2 --image=raghavendrasomannavar/amr7/ubuntu-hd:1.0.0 --replicas=7 --port=80` on master.
8. Expose pods by executing `kubectl expose deployment hw2 --port 80` on master node.
9. Check if all containers are up and running by executing `kubectl get endpoints hw2` on master.
10. Deploy load balancer [As mentioned in the Hypriot Blog].
11. Deploy kubernetes dashboard [As mentioned in the Hypriot Blog].

##### With Kube-Construct #####

1. Follow till Step-2 above.
2. Use `setupMaster.sh` to setup the master and slave nodes.
3. Follow from Step-6 to Step-11.

### Team members ###

* Sankul Rawat
* Harsh P Bajaj
* Muttavarapu Sreeharsha
* Raghavendra Somannavar
* Harshit Pant
* Rushit Thakkar
* Jose George
* Sai Sharan Nagulapalli