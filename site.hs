--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll
import Data.Maybe( fromMaybe )

getStyle item = do
  metadata <- getMetadata (itemIdentifier item)
  return (fromMaybe "personal" (lookupString "style" metadata))

-- https://jaspervdj.be/hakyll/tutorials/04-compilers.html#templates-context
styleField = field "style" getStyle

{-

 jaspervdj.be/hakyll/reference/Hakyll-Core-Rules.html
 jaspervdj.be/hakyll/reference/Hakyll-Core-Identifier-Pattern.html

 -}

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "fonts/*/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.md", "contact.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "time.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"

            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "reiterated/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/reiterated.html" reiteratedCtx
            >>= loadAndApplyTemplate "templates/default.html" reiteratedCtx
            >>= relativizeUrls

    match "reitera.html" $ do
        route idRoute
        compile $ do
            posts <- chronological =<< loadAll "reiterated/*"

            let indexCtx =
                    listField "reiterated" reiteratedCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            getResourceBody
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler

    match "universes/*/**" $ do
        route   idRoute
        compile copyFileCompiler

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx = mconcat [dateField "date" "%B %e, %Y", styleField, defaultContext]

reiteratedCtx :: Context String
reiteratedCtx = mconcat [styleField, defaultContext]
