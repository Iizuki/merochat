module Shared.Avatar where

import Prelude

import Data.Maybe (Maybe)
import Data.Maybe as DM
import Shared.Path as SP
import Shared.ContentType (ContentType(..))
import Shared.Unsafe as SU
import Shared.Options.File (imageBasePath)

defaultAvatarName ∷ String
defaultAvatarName = baseFileName <> show "1"

defaultAvatar ∷ String
defaultAvatar = fileName 1

differentAvatarImages ∷ Int
differentAvatarImages = 8

baseFileName ∷ String
baseFileName = "avatar-"

fileName ∷ Int → String
fileName index = SP.pathery PNG $ baseFileName <> show index

avatarForSender ∷ Maybe String → String
avatarForSender = DM.fromMaybe defaultAvatar

avatarForRecipient ∷ Maybe Int → Maybe String → String
avatarForRecipient index = DM.fromMaybe (fileName <<< avatarIndex $ SU.fromJust index)

avatarIndex ∷ Int → Int
avatarIndex index = mod index differentAvatarImages + 1

avatarColorClass ∷ Maybe Int → String
avatarColorClass index = " avatar-color-" <> show (mod (SU.fromJust index) totalColorClasses + 1)
      where
      totalColorClasses = 4

parseAvatar ∷  Maybe String → Maybe String
parseAvatar avatar = (imageBasePath <> _) <<< ("upload/" <> _ ) <$> avatar