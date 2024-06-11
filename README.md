<a name="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


# GH Actions Template

This repo aims to be my personal template to create new repositories with predefined workflows.

The goal is keep this repo updated with new workflows when there's a need of that.


<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#current-flows">Current Flows</a>
      <ul>
        <a href="#auto-pr">Auto PR</a>
        <ul>
            <a href="#how-to-config">How to config</a>
        </ul>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



## Current Flows

```
~/.github/workflows/
│
├── auto-generate-pr.yml            # This workflow, as the name said, aims to create a new PR for a commit made to a feature/* branch
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Auto PR

The main goal of this workflow it's automate the PR's creation for personal repos. Stop creating PR's manually or commiting just to one branch, create as many branch do you want and use this workflow to auto send them to the main branch.

*Advertising*<br>
Do not use this workflow for teams.
To do that you have to change the workflow removing the auto merge option.

#### How to config

The first thing you'll have to do is create a token to gh-actions access your repository:

1. You have to enter in your github account, click on your photo on the right screen side and go to settings;
2. Once there, in the left panel scroll down until you find the **Developer settings** and click it;
3. In the new page, click on **Personal access tokens**, to expand the selection, and choose **Fine-grained tokens**;
4. Generate a new token with access permissions to all your repositories and repositories permissions to **Read and Write**;
5. Save this token in a safe place to use on your repositories;

With the token in hands, follow to your desired repository and access the settings page of that repo.

1. In the settings page, on the left panel, access the **Secrets and variables** section to expand the list, under Security options and click on **Actions**;
2. On that page, you can create a new *Repository secret*, it will store the token that you had created in the previous step;
3. Click on **New repository secret**, put the name as 'TOKEN', all caps, and paste the token on the *Secret* section, then save and you're ready to go;


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'feat: Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Bruno Garcia Moura - itsme@bgarciamoura.com


<p align="right">(<a href="#readme-top">back to top</a>)</p>



[contributors-shield]: https://img.shields.io/github/contributors/bgarciamoura/gh-actions-template.svg?style=for-the-badge
[contributors-url]: https://github.com/bgarciamoura/gh-actions-template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/bgarciamoura/gh-actions-template.svg?style=for-the-badge
[forks-url]: https://github.com/bgarciamoura/gh-actions-template/network/members
[stars-shield]: https://img.shields.io/github/stars/bgarciamoura/gh-actions-template.svg?style=for-the-badge
[stars-url]: https://github.com/bgarciamoura/gh-actions-template/stargazers
[issues-shield]: https://img.shields.io/github/issues/bgarciamoura/gh-actions-template.svg?style=for-the-badge
[issues-url]: https://github.com/bgarciamoura/gh-actions-template/issues
[license-shield]: https://img.shields.io/github/license/bgarciamoura/gh-actions-template.svg?style=for-the-badge
[license-url]: https://github.com/bgarciamoura/gh-actions-template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/bgarciamoura
