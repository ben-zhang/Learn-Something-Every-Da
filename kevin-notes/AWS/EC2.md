# Amazon Elastic Compute Cloud
Compute is the amount of resources (Memory, CPU, Network Performance, Storage) required to fulfill a workload. EC2 is Amazon's offering for compute. There are many flavors that offer different combinations of resources optimized for different kinds of tasks.
- **Amazon Machine Images (AMI)** are the initial state for EC2 instances (snapshot of computer state)
- security groups act as a firewall for inbound (and outbound) network traffic
- storage is ephemeral unless an Elastic Block Storage Volume (EBS) is mounted
- three instance types: on-demand, reserved and spot
- spot instances are cheapest and are purchased based on highest bidding customers, which means machines can be shut down at any time based on market demand
- **placement groups** are logical groups of instances that allow for co-location within availability zones to reduce network latency
- **Elastic Block Store** provides persistent block storage, which is useful for durability where instance storage isn't sufficient
  - magnetic volumes are cheapest
  - general-purpose SSD which accumulates I/O operations per second (IOPS) credits when inactive and otherwise are slightly rate limited for cost efficiency
  - provisioned IOPS SSDs allow you to specify I/O requirements and pay for what you need
  - EBS contends for some of the network throughput for an instance, and I imagine that I/O operations have significantly higher latency than on instance storage while costing more
- Amazon EBS-optimized instances ensure additional dedicated network capacity for the EBS I/O

### Scripting
`user data` is a configurable parameter that allows execution of scripts or configuration tasks
- two types are shell scripts and cloud-init directives
- cloud-init is a tool across many linux distributions for automating config and setup alongside AMIs or as a part of AMIs

### [Block Device Mapping](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html)
Each system has an associated root device volume (EBS or instance store). Block device mapping allows additional EBS or instances store volumes to be attached to the system on launch.
- a **block device** is a OS-level concept
