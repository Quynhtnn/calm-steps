# Calm Steps — Nine User Stories

These are nine project-specific stories aligned to the nine screen/feature groups in the supplied final rubric. Earlier lab story wording was not included; compare against it if your course requires exact wording.

## US-1: Registration and login

As a user, I want to register with a username, email and password and log in so that I can access my local account.

Acceptance criteria: Invalid fields show errors; valid signup opens Home; wrong credentials show an error; a stored account can log in after logout.

## US-2: Home

As a user, I want to view recommended meditations so that I can choose a practice.

Acceptance criteria: Home shows a logo, username and three tappable meditation cards.

## US-3: Detail and navigation

As a user, I want to open meditation instructions and return to Home so that I can understand and choose a practice.

Acceptance criteria: Tap a card to open its matching title/instructions; back returns to Home; start runs a foreground timer.

## US-4: Favorites / profile

As a user, I want to save favorite meditations and see my profile so that I can find practices I enjoy.

Acceptance criteria: Heart toggles a favorite; Favorites/Profile shows username and saved titles.

## US-5: Local persistence

As a user, I want to keep favorites and preferences after reopening the app so that I can continue with my choices.

Acceptance criteria: After a cold restart, favorite titles, theme and duration remain; the snapshot reloads stored values.

## US-6: External API

As a user, I want to view weather from an external API so that I can plan mindful walks.

Acceptance criteria: Mindful world loads real Open-Meteo temperature, wind and update time for a fixed Ho Chi Minh City demo location; shows loading and retry on failure.

## US-7: Settings menu

As a user, I want to open an organized menu so that I can reach app features easily.

Acceptance criteria: Menu icon opens Favorites, Mindful world, preferences, notifications, help and logout.

## US-8: Settings and preferences

As a user, I want to change the theme and meditation duration so that I can personalize my practice.

Acceptance criteria: Dark mode changes the UI; duration offers 1/5/10/15 minutes; both persist.

## US-9: Local notifications

As a user, I want to choose a reminder title, date and time and enable or cancel it so that I can remember to meditate.

Acceptance criteria: With OS permissions granted, schedule creates one native reminder; background test triggers a real OS alert; OFF/logout cancels it.

