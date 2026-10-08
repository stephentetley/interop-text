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

pub mod InteropText.CollatorBuilder {

    use cl::InteropLocale.Locale

    

    import java.text.{Collator => JCollator}

    pub eff LocaleBuilder {
        def setDecomposition(mode: Int32): Unit
        def setStrength(strength: Int32): Unit
    }
    

    // Builder?

    // pub def setDecomposition!(mode: Int32, c: MutCollator[r]): Unit \ r =
    //     import java.text.Collator.setDecomposition(Int32): Unit \ r;
    //     let MutCollator(c1) = c;
    //     setDecomposition(c1, mode)

    // pub def setStrength!(strength: Int32, c: MutCollator[r]): Unit \ r =
    //     import java.text.Collator.setStrength(Int32): Unit \ r;
    //     let MutCollator(c1) = c;
    //     setStrength(c1, strength)

}

