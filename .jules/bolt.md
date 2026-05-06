## 2024-05-23 - Redundant List Filtering in Build Method
**Learning:** Accessing computed properties (getters) that perform list filtering multiple times within a `build` method, especially inside a `ListView.itemBuilder`, leads to $O(N \cdot M)$ complexity where $N$ is total items and $M$ is visible items. This causes unnecessary list allocations and iterations on every frame.
**Action:** Cache the result of filtering getters in a local variable at the beginning of the `build` method to ensure filtering logic runs only once per frame.
## 2026-05-06 - Redundant List Filtering in Build Method (Clinical Modules)
**Learning:** This anti-pattern was found across multiple modules (Pharmacy, Lab, Appointments, EMR, Notifications, Telemedicine). Accessing getters that perform list filtering/sorting multiple times within a build method creates unnecessary overhead.
**Action:** Consistently cache the result of these getters in a local variable at the start of the build method. This was applied to PharmacyHomeScreen, LabHomeScreen, StaffAppointmentsHome, EmrHomeScreen, NotificationsScreen, and TeleHomeStaffScreen.
