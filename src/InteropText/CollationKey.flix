/*
 * Copyright 2026 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

pub mod InteropText.CollationKey {

    use ae::JavaInterop.AdaptorUnchecked
    use cl::InteropLocale.Locale

    import java.text.{CollationKey => JCollationKey}

    pub enum CollationKey(JCollationKey)

    instance ToJava[CollationKey] {
        type Out = JCollationKey
        pub def toJava(x: CollationKey): JCollationKey = 
            let CollationKey.CollationKey(x1) = x;
            x1
    }

    instance ToFlix[CollationKey] {
        type In = JCollationKey
        pub def toFlix(x: JCollationKey): CollationKey = 
            CollationKey.CollationKey(x)
    }

    ///
    /// Compare two CollationKeys.
    ///
    pub def compare(x: CollationKey, y: CollationKey): Comparison =
        AdaptorUnchecked.extract2(x, y, (x1, y1) -> 
            unsafe IO { let cmp = x1.compareTo(y1); Comparison.fromInt32(cmp) }
        )

    pub def getSourceString(x: CollationKey): String =
        AdaptorUnchecked.extract(x, x1 -> unsafe IO { x1.getSourceString() })

}

