# 🤖 ABB MultiMove — SyncMove vs Non‑Synchronizing Motion

This repository demonstrates **true coordinated motion** between two ABB robots using **MultiMove SyncMove**, and contrasts it with **non‑synchronized (independent) motion**.

The goal is not to explain every RAPID instruction line‑by‑line, but to clearly show **why SyncMove + Motion IDs matter**, and what actually changes in robot behavior when they are used.

---

## 📁 Repository Structure

```
Multimove/
├── Synchronizing/
│   ├── Robot 1/
│   │   └── MODULE Module1.mod
│   └── Robot 2/
│       └── MODULE Module1.mod
│
├── non Synchronizing/
    ├── Robot 1/
    │   └── MODULE Module1.mod
    └── Robot 2/
        └── MODULE Module1.mod
```

Each folder contains **Robot‑1 and Robot‑2 RAPID programs** for the same geometric path, executed under different coordination strategies.

---

## 🧭 Scenario Overview

Both robots are programmed with:

* Identical Cartesian targets
* Linear motion (`MoveL`)
* Blended paths (`z100`)

The **only difference** is how motion coordination is handled.

This makes the comparison clean and honest: geometry stays the same, timing logic changes.

---

## ✅ Synchronizing Folder — True MultiMove SyncMove

This folder demonstrates **ABB MultiMove SyncMove**, where two robots behave as **one coordinated motion system**.

Key characteristics of the code:

* `WaitSyncTask` ensures both robot tasks are aligned before motion starts
* `SyncMoveOn` places both robots into a shared motion group
* Motion commands contain **Motion IDs** (`\ID:=10`, `\ID:=20`, …)
* `SyncMoveOff` cleanly exits coordinated mode after the path

Even though:

* Robot‑1 runs at **v500**
* Robot‑2 runs at **v1000**

ABB internally **rescales time**, not distance.

### What this means in motion:

* Each motion segment **starts together**
* Each target is **reached at the same time**
* Acceleration, deceleration, and blending are **time‑locked**
* One robot cannot advance while the other lags

The robots are no longer two timelines — they share **one timeline**.

---

## 🆔 Motion IDs — Why They Exist

Motion IDs are not optional decoration.

Conceptually, each `\ID:=n` does three critical things:

* Maps which motion in Robot‑1 corresponds to Robot‑2
* Locks both robots to the same path step
* Prevents mid‑path desynchronization

A helpful mental model:

> **Motion IDs act like timestamps for coordinated motion.**

Without matching IDs, SyncMove cannot guarantee alignment — even if the paths look identical.

---

## 🚫 non Synchronizing Folder — Independent Motion

This folder shows what happens **without SyncMove**.

Characteristics of the code:

* No `WaitSyncTask`
* No `SyncMoveOn / SyncMoveOff`
* No Motion IDs
* Each robot executes its own `MoveL` sequence independently

Even with identical targets:

* Each robot plans its own trajectory
* Acceleration and deceleration differ
* Targets are reached at different times

### Visual result:

* Motions may look similar
* Robots are **not time‑locked**
* Synchronization happens only by coincidence

This is **not MultiMove coordination** — it is parallel execution.

---

## 🧠 Key Takeaways

* Without SyncMove, robots move together **by coincidence**
* With SyncMove, robots move together **by design**
* Motion IDs are essential for deterministic coordination
* Speed values (`v500`, `v1000`) do **not** break synchronization when SyncMove is active

---

This backup contains **all required files** to reproduce the simulation for both motion modes:

- **SyncMove (Synchronized Motion)**
- **Non-SyncMove (Independent Motion)**

### What the backup includes

- Complete controller configuration
- MultiMove task setup (`T_ROB1`, `T_ROB2`)
- RAPID modules for **synchronized** and **non-synchronized** motion
- Identical geometric paths for both robots
- Tested and validated in RobotStudio with OmniCore v250XT

### Simulation behavior

The included RobotStudio simulation clearly shows:

- Two ABB robots executing the same geometric path
- Time-locked motion when **SyncMove + Motion IDs** are enabled
- Independent timing when SyncMove is disabled

This backup ensures the project is **fully reproducible**, allowing users to load the controller, switch between **Sync** and **UnSync** folders, and directly observe the motion differences.



---

## 🛠 Requirements

* ABB RobotStudio
* ABB RobotWare with **MultiMove** option enabled
* Two robot tasks (`T_ROB1`, `T_ROB2`)
