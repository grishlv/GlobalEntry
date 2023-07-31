# Global Entry
Global Entry — travel mobile application that helps people quickly find information about visa requirements in different countries of the world. The app was launched in 2023, born out of our personal desire for such a resource. It soon became clear that we weren't alone in this need. The app is currently only available on the App Store for iPhone users.

<p float="left">
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/16448077-352b-417a-ab13-06d02db4e839"" width="32%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/343bbe16-b834-4ef0-973f-06416619e50d" width="32%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/3ae81052-8eb9-4ef7-9fc5-d28f39d68e28" width="32%" />
 </p>

## Features

1. First steps
2. Main feature
3. Add to favourites
4. Filter by category
5. Other features

## 1. First steps

The first steps begin with the welcome screens. After that, you will need to choose a passport of your country.

<p float="left">
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/c2dc3045-fcaf-4078-b69e-9961c9f08a6a" width="20%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/c1e090bb-45a5-469c-8896-2a33ef852ef4" width="20%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/c6150cda-bcb4-48c6-9589-b3ab0fb31bd0" width="20%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/8477017c-123f-457d-94a3-9098e9c80670" width="20%" />
 </p>

## 2. Main Feature

On the main screen you can observe visa conditions in all 199 countries. The search will help you find a specific country quickly.

<p float="left">
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/bb0fa1f2-d351-4b2e-b458-1b19ea6bc066" width="20%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/e7c2fbbb-c671-4877-a5c5-3f21d588c3b5" width="20%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/a05e9081-5935-4cf0-acce-51424c5f9b18" width="20%" />
 </p>

## 3. Add to favourites

In favorites, you can add countries that you would like to visit and make a comparison.

<p float="left">
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/0fe7fc3e-9ca1-40eb-b847-32201388b481" width="20%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/ec9b9f43-6529-48a4-9641-1e171e7702d6" width="20%" />
</p>

## 4. Filter by category

In filter category you can select the conditions you are interested in. For example, you want to travel to Latin American countries and not have visa restrictions.

<p float="left">
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/e978b7ea-ab1f-469f-8cd1-1b0442bbaad7" width="20%" />
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/dccdf1a9-0b7d-49dd-a087-8b75bf4c81d8" width="20%" />
</p>

## 5. Other features

You can also change your passport to compare visa conditions in different countries. But be careful that when you change your passport, the countries added to favorites will disappear. You can also view FAQ, contact us or read more about the app.

<p float="left">
	<img src="https://github.com/grishlv/GlobalEntry/assets/115469316/83459efa-976d-4701-aeb0-59b567478183" width="20%" />
</p>
 
In the near future, I plan to introduce features that will provide in-depth information about each country. This will help our users gain better awareness before their visits, enhancing their travel experience.

# Development

When developing the application, I used third-party libraries such as:
- SnapKit for faster work with constraints
- KingFisher for smoother work with images and uploading them to the cache
- Firebase Storage for image parsing
- To work with data, I chose the Realm instead of CoreData, since the project is still small and there is no need to use a more complex database
- All information is stored with a big JSON file

Also about project:
- The architecture is mostly MVVM with the presence of MVC. Somewhere the work is implemented through protocols, somewhere there is using Combine.
- Dependency Manager: Swift Package Manager.
- GitHub for changes and commits.

# Attributions

## Database 

I used the database provided by the website Passport Index. According to Passport Index, it is a free tool built with publicly available information and content contributed by fans and government agencies from around the world. You are free to use the dataset under the MIT license.

Source: https://www.passportindex.org

For more convenient work with data, I used an open data project: https://github.com/ilyankou/passport-index-dataset/tree/master

## Photo Credits

I used photos with a free license from the Unsplash web-site, which doesn't require mentioning the photographers credit, but I will add their links later.

