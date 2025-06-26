# Sensor Fusion Demo: Complementary Filter

Sensor fusion combines data from multiple sensors to produce more accurate, reliable, or comprehensive information than could be achieved by using a single sensor alone. In robotics, a common example is combining accelerometer and gyroscope data to estimate orientation.

This demo uses a simple complementary filter to fuse noisy accelerometer and gyroscope data for estimating the angle of a simulated robot.

## How It Works
- **Accelerometer**: Measures angle with noise and is sensitive to acceleration.
- **Gyroscope**: Measures angular velocity, which can be integrated to get angle, but drifts over time.
- **Complementary Filter**: Blends both measurements to get a stable and accurate angle estimate.

## Python Demo
Copy and run the following code in a Jupyter notebook or Python script:

```python
import numpy as np
import matplotlib.pyplot as plt

dt = 0.01
T = 10
N = int(T/dt)
t = np.linspace(0, T, N)

true_angle = 45 * np.sin(2 * np.pi * 0.1 * t)

acc_noise = np.random.normal(0, 2, N)
acc_angle = true_angle + acc_noise

gyro_noise = np.random.normal(0, 0.5, N)
gyro_drift = 0.05 * t
gyro_rate = np.gradient(true_angle, dt) + gyro_noise + gyro_drift

gyro_angle = np.zeros(N)
for i in range(1, N):
    gyro_angle[i] = gyro_angle[i-1] + gyro_rate[i] * dt

alpha = 0.98
fused_angle = np.zeros(N)
for i in range(1, N):
    fused_angle[i] = alpha * (fused_angle[i-1] + gyro_rate[i] * dt) + (1 - alpha) * acc_angle[i]

plt.figure(figsize=(10,6))
plt.plot(t, true_angle, label='True Angle')
plt.plot(t, acc_angle, label='Accelerometer', alpha=0.5)
plt.plot(t, gyro_angle, label='Gyroscope', alpha=0.5)
plt.plot(t, fused_angle, label='Fused (Complementary Filter)', linewidth=2)
plt.legend()
plt.xlabel('Time (s)')
plt.ylabel('Angle (deg)')
plt.title('Sensor Fusion Demo: Complementary Filter')
plt.grid()
plt.show()
```

## What You Should See
- The accelerometer signal is noisy.
- The gyroscope signal drifts over time.
- The complementary filter output closely follows the true angle, showing the power of sensor fusion.

---

**Try changing the noise levels or the filter parameter `alpha` to see how the fusion behaves!**
