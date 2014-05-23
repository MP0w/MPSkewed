MPSkewed
=================

## History

I wanted to make something like this since I saw [this collectionView](http://capptivate.co/2014/01/18/timbre-2/)
While I was waiting to have the time to make it [TWRSkewedCollectionView](https://github.com/chasseurmic/TWRSkewedCollectionView) came out.
Suddenly I forked it and [decided to contribute](https://github.com/MP0w/TWRSkewedCollectionView/commits/master),
I was going to add the parallax effect when I realized that there were some decision that I didn't like so I preferred to use that as a base but I need to edit a lot of stuff that probably the original owner do not want to change.
For example: I want a collection view that works like any other collectionView, where the user needs to provide a dataSource instead of load a simple list of URL for the images.
just to have it as exensible as the originalCollection.
I don't like nib, and this project shouldn't be a collectionview but a layout+cell
Even for the way how the original is structured is difficult to add the parallax effect or edit the behaviour, and it becomes too much confusionary...

At the end I guess there are no code shared between the two, TWRSkewedCollectionView is just simple to use but not really reusable/customizable since it does all alone.

## MPSkewed

![](img/screen.png)

## License

Usage is provided under the [MIT License](http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.
