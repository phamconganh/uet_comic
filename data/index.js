const gsjson = require('google-spreadsheet-to-json');
const admin = require("firebase-admin");
const util = require('util');
const serviceAccount = require("./uet-comic-4ca04-firebase-adminsdk-gywgi-15e370b56e.json");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://uet-comic-4ca04.firebaseio.com"
});
const db = admin.firestore();
const comicCollection = db.collection("comic");
const chapterCollection = db.collection("chapter");
const authorCollection = db.collection("author");
const typeCollection = db.collection("type");
const searchCollection = db.collection("search");

// todo can check lai \s

gsjson({
    spreadsheetId: '1uJFd0lZzymdqNJ0yE09D1U7u9bFyE0bn9mH9yJ3jzPg',
    worksheet: ["comic", "chapter", "author", "type"]
})
    .then(function (result) {

        // /** create chapter collection */
        const chapters = result[1];
        // chapters.forEach(chapter => {
        //     try {
        //         chapter.images = chapter.images.split(",");
        //         for (let index = 0; index < chapter.images.length; index++) {
        //             chapter.images[index] = chapter.images[index].trim();
        //         }
        //         chapter.lastUpdate = new Date(Date.UTC(0) + (chapter.lastUpdate - 2) * 24 * 60 * 60 * 1000);
        //         // chapterCollection.doc(chapter.id.toString()).set(chapter, { merge: true });
        //     } catch (error) {
        //         console.log(error)
        //     }
        // });

        /** create author collection */
        const authors = result[2];
        // authors.forEach(author => {
        //     authorCollection.doc(author.id.toString()).set(author, { merge: true });
        // });

        /** create type collection */
        const types = result[3];
        // types.forEach(type => {
        //     typeCollection.doc(type.id.toString()).set(type, { merge: true });
        // });

        // /** create comic collection */
        // const comics = result[0];
        // comics.forEach(comic => {
        //     try {
        //         comic.author = authors.find(element => element.id == comic.idAuthor);

        //         comic.idTypes = comic.idTypes.split(",");
        //         for (let index = 0; index < comic.idTypes.length; index++) {
        //             comic.idTypes[index] = comic.idTypes[index].trim();
        //         }

        //         comic.types = [] ;
        //         for (let index = 0; index < comic.idTypes.length; index++) {
        //             let type = types.find(element => element.id == comic.idTypes[index]);
        //             comic.types.push(type);
        //         }

        //         delete comic.idAuthor;
        //         delete comic.idTypes;

        //         comic.idChapters = comic.idChapters.split(",");
        //         for (let index = 0; index < comic.idChapters.length; index++) {
        //             comic.idChapters[index] = comic.idChapters[index].trim();
        //         }
        //         comic.lastChapter = chapters.find(element => element.id == comic.idChapters[comic.idChapters.length -1]).name;
        //         delete comic.idChapters;

        //         comic.lastUpdate = new Date(Date.UTC(0) + (comic.lastUpdate - 2) * 24 * 60 * 60 * 1000);

        //         /** tach thanh tung tu */
        //         // let splitNames = comic.name.split(/\s+/);
        //         // comic.searchIndexs = [];
        //         // for (let index = 0; index < splitNames.length; index++) {
        //         //     const splitName = splitNames[index];
        //         //     for (let i = 0; i < splitName.length; i++) {
        //         //         let searchIndex = splitName.substring(0, i + 1).toLowerCase();
        //         //         comic.searchIndexs.push(searchIndex);
        //         //         let plusSearchIndex = searchIndex.normalize("NFD")
        //         //             .replace(/[\u0300-\u036f]/g, "")
        //         //             .replace(/đ/g, "d")
        //         //             .replace(/Đ/g, "D")
        //         //         if (searchIndex !== plusSearchIndex) {
        //         //             comic.searchIndexs.push(plusSearchIndex);
        //         //         }
        //         //     }
        //         // }

        //         comic.searchIndexs = [];
        //         for (let i = 0; i < comic.name.length; i++) {
        //             let searchIndex = comic.name.substring(0, i + 1).toLowerCase();
        //             comic.searchIndexs.push(searchIndex);
        //             let plusSearchIndex = searchIndex.normalize("NFD")
        //                 .replace(/[\u0300-\u036f]/g, "")
        //                 .replace(/đ/g, "d")
        //                 .replace(/Đ/g, "D")
        //             if (searchIndex !== plusSearchIndex) {
        //                 comic.searchIndexs.push(plusSearchIndex);
        //             }
        //         }
        //         comicCollection.doc(comic.id.toString()).set(comic, { merge: true });
        //         // comicCollection.doc(comic.id.toString()).set(comic);
        //     } catch (error) {
        //         console.log(error, comic.id, comic.idTypes)
        //     }
        // });

        // // console.log(util.inspect(comics, false, null, true /* enable colors */))



        // /** create search collection */
        const searches = result[0];
        searches.forEach(search => {
            try {
                delete search.idAuthor;
                delete search.idTypes;
                delete search.idChapters;
                delete search.imageLink;
                delete search.state;
                delete search.content;
                delete search.view;
                delete search.like;
                delete search.follow;
                delete search.age;
                delete search.gender;
                delete search.lastUpdate;

                search.searchIndexs = [];
                for (let i = 0; i < search.name.length; i++) {
                    let searchIndex = search.name.substring(0, i + 1).toLowerCase();
                    search.searchIndexs.push(searchIndex);
                    let plusSearchIndex = searchIndex.normalize("NFD")
                        .replace(/[\u0300-\u036f]/g, "")
                        .replace(/đ/g, "d")
                        .replace(/Đ/g, "D")
                    if (searchIndex !== plusSearchIndex) {
                        search.searchIndexs.push(plusSearchIndex);
                    }
                }
                // searchCollection.doc(search.id.toString()).set(search, { merge: true });
                searchCollection.doc(search.id.toString()).set(search);
            } catch (error) {
                console.log(error, searches.id);
            }
        });

        console.log(util.inspect(searches, false, null, true /* enable colors */))
    })
    .catch(function (err) {
        console.log(err.message);
        console.log(err.stack);
    });

// comic.lastUpdate = new Date(Date.UTC(0) + (comic.lastUpdate - 2) * 24 * 60 * 60 * 1000).toLocaleDateString('vn-VN', { timeZone: 'UTC' });
